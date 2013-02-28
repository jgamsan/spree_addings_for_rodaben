Spree::Order.class_eval do

  attr_accessible :workshop_id
  belongs_to :workshop

  #self.state_machine.after_transition :to => :complete, :do => :check_emails_to_send

  def check_emails_to_send
    deliver_order_company_provider_email unless payment_by_transfer?
    deliver_order_workshop_email unless self.workshop_id.nil?
  end

  def deliver_order_company_provider_email
    begin
      @suppliers = Spree::Supplier.all
      @suppliers.each do |supplier|
        @line_items = Spree::LineItem.joins(:variant, :product).where("spree_products.supplier_id = ? and spree_line_items.order_id = ?", supplier.id, self.id)
        Spree::NotifyMailer.send_email_to_provider(self, @line_items).deliver unless @line_items.empty?
      end
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

  def deliver_order_workshop_email
    begin
      @line_items = Spree::LineItem.where(:order_id => self.id)
      Spree::NotifyMailer.send_email_to_workshop(self, @line_items).deliver
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

  def payment_by_transfer?
    self.payment.payment_method.type == "Spree::PaymentMethod::Check" ? true : false
  end


end
