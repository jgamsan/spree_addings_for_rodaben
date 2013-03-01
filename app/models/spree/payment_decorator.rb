Spree::Payment.class_eval do
  
  self.state_machine.after_transition :to => 'completed', :do => :email_to_provider_if_payment
  
  def email_to_provider_if_payment
    if self.payment_method.type == "Spree::PaymentMethod::Check"
      begin
        @suppliers = Spree::Supplier.all
        @order = self.order
        @suppliers.each do |supplier|
          @line_items = Spree::LineItem.joins(:variant, :product).where("spree_products.supplier_id = ? and spree_line_items.order_id = ?", supplier.id, self.order_id)
          Spree::NotifyMailer.send_email_to_provider(@order, @line_items).deliver unless @line_items.empty?
        end
        Spree::NotifyMailer.send_email_bank_transfer_received(@order).deliver
      rescue Exception => e
        logger.error("#{e.class.name}: #{e.message}")
        logger.error(e.backtrace * "\n")
      end
    end
  end

end