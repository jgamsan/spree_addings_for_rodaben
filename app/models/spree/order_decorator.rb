Spree::Order.class_eval do

  def deliver_order_company_provider_email
    begin
      NotifyMailer.send_email_to_provider(self).deliver
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

  state_machine :initial => 'cart', :use_transactions => false do
    event :next do
      transition :from => 'cart',     :to => 'address'
      transition :from => 'address',  :to => 'delivery'
      transition :from => 'delivery', :to => 'payment', :if => :payment_required?
      transition :from => 'delivery', :to => 'complete'
      transition :from => 'confirm',  :to => 'complete'
      transition :from => 'complete', :to => 'approval'

      # note: some payment methods will not support a confirm step
      transition :from => 'payment',  :to => 'confirm',
                                      :if => Proc.new { |order| order.payment_method && order.payment_method.payment_profiles_supported? }

      transition :from => 'payment', :to => 'complete'
    end

    event :cancel do
      transition :to => 'canceled', :if => :allow_cancel?
    end
    event :return do
      transition :to => 'returned', :from => 'awaiting_return'
    end
    event :resume do
      transition :to => 'resumed', :from => 'canceled', :if => :allow_resume?
    end
    event :authorize_return do
      transition :to => 'awaiting_return'
    end

    before_transition :to => 'complete' do |order|
      begin
        order.process_payments!
      rescue Core::GatewayError
        !!Spree::Config[:allow_checkout_on_gateway_error]
      end
    end

    before_transition :to => ['delivery'] do |order|
      order.shipments.each { |s| s.destroy unless s.shipping_method.available_to_order?(order) }
    end
    after_transition :to => 'approval', :do => :request!
    after_transition :to => 'complete', :do => :finalize!
    after_transition :to => 'delivery', :do => :create_tax_charge!
    after_transition :to => 'payment',  :do => :create_shipment!
    after_transition :to => 'resumed',  :do => :after_resume
    after_transition :to => 'canceled', :do => :after_cancel
  end

  def request!
    deliver_order_company_provider_email
  end

end
