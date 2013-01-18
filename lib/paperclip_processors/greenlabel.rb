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
      @image = MiniMagick::Image.open("#{Rails.root}/app/assets/images/base_etiqueta.jpg")
    end

    def make
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      begin
        result = @image.composite(MiniMagick::Image.open(overfile, "jpg")) do |c|
          c.gravity "center"
          c.geometry "-13-33"
        end
        result = result.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/d.jpg", "jpg")) do |c|
          c.gravity "center"
          c.geometry "+103+13"
        end
        result = result.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/emision_ruido_3.jpg", "jpg")) do |c|
          c.gravity "center"
          c.geometry "-30+165"
        end
        result.combine_options do |c|
          c.gravity "center"
          c.pointsize '30'
          c.draw "text 60,168 '73'"
          c.font 'arial'
          c.fill "#FFFFFF"
        end
      rescue Exception => e
        raise e, "Hubo un error en el proceso de creacion etiqueta CEE"
      end
      result.write dst
    end

    def basefile
      "#{Rails.root}/app/assets/images/base_etiqueta.jpg"
    end

    def overfile
      "#{Rails.root}/app/assets/images/b.jpg"
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end
  end

  class Offertmark
    def initialize file, options = {}, attachment = nil
      @file = file
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @format = options[:format]
      @offertmark_path = options[:offertmark_path]
      @position = options[:offertmark_position].nil? ? "SouthEast" : options[:offertmark_position]

      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
    end

    def make
      return @file unless offertmark_path

      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      command = "composite"
      params = "-gravity #{@position} #{offertmark_path} #{fromfile} #{tofile(dst)}"

      begin
        success = Paperclip.run(command, params)
      rescue Cocaine::CommandLineError => ex
        raise ex, "There was an error processing the watermark for #{@basename}" if @whiny
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