Spree::Order.class_eval do

  def finalize!
    super
    deliver_order_company_provider_email
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