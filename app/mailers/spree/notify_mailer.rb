# encoding: UTF-8
module Spree
  class NotifyMailer < ActionMailer::Base
    default :to => ["miguel.gamazo@galiclick.com", "juan.tato@galiclick.com", "rodaben71@gmail.com"]

    def file_notification(file)
      attachments[file] = File.read("#{Rails.root}/public/images/uploads/" + file)
      mail(:subject => "Enviando archivo con Items eliminados por Focal")
    end

    def report_notification(readed, updated, deleted, created, directory, file, company)
      attachments[file] = File.read(File.join(directory, file))
      @readed = readed
      @updated = updated
      @deleted = deleted
      @created = created
      @company = company
      mail(:subject => "Enviando Informe con las estadisticas de la actualizacion de la Empresa #{company}")
    end

    def report_deleted_items(deleted, category)
      @deleted = deleted
      @category = category
      mail(:subject => "Enviando Informe de Items Borrados en Articulos")
    end

    def send_email_to_provider(order, line_items, resend = false)
    @order = order
    @line_items = line_items
    subject = (resend ? "[#{t(:resend).upcase}] " : '')
    subject += "Prueba de envio de Orden a la Compañia #{order.line_item.variant.product.supplier.title.first} #{order.number}"
    mail(:to => "miguel.gamazo@galiclick.com",
         :subject => subject)
    #mail(:to => ["miguel.gamazo@galiclick.com", "juan.tato@galiclick.com", "rodaben71@gmail.com"],
    #     :subject => subject)
  end
  end
end
