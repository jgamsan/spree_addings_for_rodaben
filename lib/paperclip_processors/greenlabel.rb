module Paperclip
  class Greenlabel < Processor
    attr_accessor :format
    
    def initialize file, options = {}, attachment = nil
      @file = file
      @id_path = "Rails.root.to_s/app/assets/images"
      @format = options[:format]
      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
      @position = "center"
    end
    
    def make
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode 
      
      command = "composite"
      params = "-gravity #{@position} -geometry -13-33 #{fromfile} #{overfile} #{tofile(dst)}"
      
      begin
        success = Paperclip.run(command, params)
      rescue Exception => e
        raise e, "Hubo un error en el proceso de creacion etiqueta CEE"
      end
      dst
    end
    
    def fromfile
      "#{Rails.root}/app/assets/images/base_etiqueta.jpg"
    end

    def overfile
      "#{Rails.root}/app/assets/images/b.jpg"
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end 

  end
end