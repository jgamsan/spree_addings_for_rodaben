# encoding: UTF-8
module Spree
  class NotifyMailer < ActionMailer::Base
    default :to => ["miguel.gamazo@galiclick.com", "juan.tato@galiclick.com", "rodaben71@gmail.com"]

    def file_notification(file)
      attachments[file] = File.read("#{Rails.root}/public/images/uploads/" + file)
      mail(:subject => "Enviando archivo con Items eliminados por Focal")
    end

    def report_notification(readed, updated, deleted, created)
      file = "listado-neumaticos-no-incorporados.csv"
      attachments[file] = File.read("#{Rails.root}/vendor/products/" + file)
      @readed = readed
      @updated = updated
      @deleted = deleted
      @created = created
      mail(:subject => "Enviando Informe con las estadisticas de la actualizacion")
    end

    def report_deleted_items(deleted, category)
      @deleted = deleted
      @category = category
      mail(:subject => "Enviando Informe de Items Borrados en Articulos")
    end

    def send_email_to_provider(order, resend = false)
    @order = order
    subject = (resend ? "[#{t(:resend).upcase}] " : '')
    subject += "Prueba de envio de Orden a la Compañia GANE ##{order.number}"
    mail(:to => ["miguel.gamazo@galiclick.com", "juan.tato@galiclick.com", "rodaben71@gmail.com"],
         :subject => subject)
  end
  end
end
