# encoding: UTF-8
Spree::Order.class_eval do

  def send_email_to_provider(order, resend = false)
    @order = order
    subject = (resend ? "[#{t(:resend).upcase}] " : '')
    subject += "Prueba de envio de Orden a la Compañia GANE ##{order.number}"
    mail(:to => "miguel.gamazo@galiclick.com;juan.tato@galiclick.com",
         :subject => subject)
  end

end
