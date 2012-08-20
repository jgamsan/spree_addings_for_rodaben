Spree::Order.class_eval do

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
        :user_id        => (Spree::User.respond_to?(:current) && Spree::User.current.try(:id)) || self.user_id
      }, :without_protection => true)
    end

  def request!
    deliver_order_company_provider_email
  end

  def deliver_order_company_provider_email
    begin
      Spree::NotifyMailer.send_email_to_provider(self).deliver
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end


end
