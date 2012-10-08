Spree::Order.class_eval do

  attr_accessor :workshop
  attr_accessible :workshop


  def finalize!
      touch :completed_at
      Spree::InventoryUnit.assign_opening_inventory(self)
      # lock any optional adjustments (coupon promotions, etc.)
      adjustments.optional.each { |adjustment| adjustment.update_column('locked', true) }
      deliver_order_confirmation_email
      deliver_order_company_provider_email
      self.state_changes.create({
        :previous_state => 'cart',
        :next_state     => 'complete',
        :name           => 'order' ,
        :user_id        => self.user_id
      }, :without_protection => true)
    end

  def request!
    deliver_order_company_provider_email
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


end
