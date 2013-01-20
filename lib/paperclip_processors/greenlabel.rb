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
      @image = "#{Rails.root}/app/assets/images/base_etiqueta.png"
    end

    def make
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      command = "convert"
      params = "-resize 300x500 #{@image} #{tofile(dst)}"
      begin
        success = Paperclip.run(command, params)
      rescue Exception => e
        raise e, "Hubo un error en el proceso de creacion etiqueta CEE"
      end
      dst
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end
  end

  class Offertmark < Processor
    attr_accessor :format, :whiny, :position
    def initialize file, options = {}, attachment = nil
      @file = file
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @format = options[:format]
      @position = "NorthWest"

      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
    end

    def make

      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      command = "convert"
      params = "-resize 240x240 #{fromfile} #{tofile(dst)}"
      command1 = "composite"
      params1 = "-gravity #{@position} #{Rails.root}/app/assets/images/yellow-m.png #{tofile(dst)} #{tofile(dst)}"

      begin
        success = Paperclip.run(command, params)
        success = Paperclip.run(command1, params1)
      rescue Cocaine::CommandLineError => ex
        raise ex, "There was an error processing the offertmark for #{@basename}" if @whiny
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

  class Newmark < Processor
    attr_accessor :format, :whiny, :position
    def initialize file, options = {}, attachment = nil
      @file = file
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @format = options[:format]
      @position = "NorthWest"

      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
    end

    def make
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      command = "convert"
      params = "-resize 240x240 #{fromfile} #{tofile(dst)}"
      command1 = "composite"
      params1 = "-gravity #{@position} #{Rails.root}/app/assets/images/blue-m.png #{tofile(dst)} #{tofile(dst)}"

      begin
        success = Paperclip.run(command, params)
        success = Paperclip.run(command1, params1)
      rescue Cocaine::CommandLineError => ex
        raise ex, "There was an error processing the newmark for #{@basename}" if @whiny
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