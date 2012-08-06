module Spree
  class TestMailer < ActionMailer::Base
    default :from => "no-reply@galiclick.com", :to => "miguel.gamazo@galiclick.com"

    def file_notification(file)
      attachments[file] = File.read("#{Rails.root}/public/images/uploads/" + file)
      mail(:subject => "Enviando archivo con Items eliminados por Focal")
    end

    def report_notification(readed, updated, deleted, created, file)
      attachments[file] = File.read(file)
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
  end
end
