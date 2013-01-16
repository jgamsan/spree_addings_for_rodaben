module Paperclip
  class Greenlabel < Processor
    def initialize file, options = {}, attachment = nil
      @file = file
      @id_path = "Rails.root.to_s/app/assets/images"
      @format = options[:format]
      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
    end
    
    def make
      begin
        dst = Tempfile.new([@basename, @format].compact.join("."))
        dst.binmode
        image = MiniMagick::Image.open(File.join(@id_path, "base_etiqueta.jpg"))
        dst = image.composite(MiniMagick::Image.open(File.join(@id_path, "b.jpg"), "jpg")) do |c|
          c.gravity "center"
          c.geometry "-13-33"
        end
        dst = dst.composite(MiniMagick::Image.open(File.join(@id_path, "d.jpg"), "jpg")) do |c|
          c.gravity "center"
          c.geometry "+103+13"
        end

        dst = dst.composite(MiniMagick::Image.open(File.join(@id_path, "emision_ruido_3.jpg"), "jpg")) do |c|
          c.gravity "center"
          c.geometry "-30+165"
        end  
      rescue Exception => e
        raise e, "Hubo un error en el proceso de creacion etiqueta CEE"
      end
      dst
    end
    
    def fromfile
      "\"#{ File.expand_path(@file.path) }[0]\""
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end 

  end
end