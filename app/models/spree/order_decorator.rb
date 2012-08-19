Spree::Order.class_eval do

  after_save :request!

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
