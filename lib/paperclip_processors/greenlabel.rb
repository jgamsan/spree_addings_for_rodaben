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
      @fuel_options = Hash["A", "-14-55", "B", "-13-33", "C", "-13-11", "D", "-13+11", "E", "-13+33", "F", "-13+55", "G", "-13+77"]
      @wet_options = Hash["A", "+103-53", "B", "+103-31", "C", "+103-9", "D", "+103+13", "E", "+103+35", "F", "+103+56", "G", "+103+78"]
    end
    
    def make
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode 
      
      command = "composite"
      comman2 = "convert"
      params = "-gravity #{@position} -geometry -13-33 #{overfile} #{fromfile} #{tofile(dst)}"
      params2 = "-gravity #{@position} -geometry +103+13 #{Rails.root}/app/assets/images/d.jpg #{tofile(dst)} #{tofile(dst)}"
      params3 = "-gravity #{@position} -geometry -30+165 #{Rails.root}/app/assets/images/emision_ruido_2.jpg #{tofile(dst)} #{tofile(dst)}"
      params4 = "-gravity center -pointsize 30 -draw text 60,168 '73' -font monospace -fill #ffffff #{tofile(dst)} #{tofile(dst)}"
      begin
        success = Paperclip.run(command, params)
        sucess = Paperclip.run(command, params2)
        sucess = Paperclip.run(command, params3)
        sucess = Paperclip.run(command2, params4)
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