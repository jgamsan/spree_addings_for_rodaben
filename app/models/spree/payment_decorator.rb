Spree::Payment.class_eval do
  after_update :email_to_provider_if_payment

  def email_to_provider_if_payment
    if (self.state_changed? || self.state == "completed" || self.payment.payment_method_id == 2)
      begin
        @suppliers = Spree::Supplier.all
        @order = self.order
        @suppliers.each do |supplier|
          @line_items = Spree::LineItem.joins(:variant, :product).where("spree_products.supplier_id = ? and spree_line_items.order_id = ?", supplier.id, self.order_id)
          Spree::NotifyMailer.send_email_to_provider(@order, @line_items).deliver unless @line_items.empty?
        end
      rescue Exception => e
        logger.error("#{e.class.name}: #{e.message}")
        logger.error(e.backtrace * "\n")
      end
    end
  end

end