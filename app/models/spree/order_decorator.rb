Spree::Order.class_eval do

  state_machine.instance_eval do
   around_transition :to => 'complete', :do => :deliver_order_company_provider_email
  end

  def deliver_order_company_provider_email
    begin
      OrderMailer.send_email_to_provider(self).deliver
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

end
