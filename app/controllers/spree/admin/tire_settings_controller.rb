module Spree
  module Admin
    class TireSettingsController < Spree::Admin::BaseController
      def search_tyre
        tyre = params[:tyre]
        @searcher = Spree::Config.searcher_class.new(params.merge(:keywords => tyre, :per_page => 25))
        @products = @searcher.retrieve_products

        respond_to do |format|
          format.js
        end
      end

      def upload_file
        productos = params[:product_ids]
        productos.each do |product|
          t = Spree::Product.find(product)
          v = t.master
          unless v.images.empty?
            v.images.destroy_all
          end
          img = Spree::Image.create!({:attachment => params[:image], :viewable => v}, :without_protection => true)
          v.images << img
          respond_to do |format|
            format.js
          end
          unless v.tire_fuel_consumption_id.nil?
            load_eco_label(v)
          end
        end

        #redirect_to load_massive_images_admin_tire_settings_url
      end

      def load_massive_images

      end

      def assign_massive_green_rate
        taxon = params[:tires_massive]
        innertube = params[:innertube]
        @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => taxon,
                                                                  :tire_innertube_id => innertube,
                                                                  :per_page => 25))
        @products = @searcher.retrieve_products
        respond_to do |format|
          format.js
        end
      end

      def load_green_rate
        productos = params[:product_ids]
        for product in productos
          t = Spree::Product.find(product)
          v = t.master
          v.update_attributes(:tire_green_rate_id => params[:green_rate])
        end
        redirect_to search_tires_for_green_rate_admin_tire_settings_url
      end

      def search_tires_for_green_rate
        @brands = Spree::Taxon.where(:parent_id => 2).order("name asc")
        @innertubes = Spree::TireInnertube.in_mm(true)
        @green_rates = Spree::TireGreenRate.all
      end

      private

      def load_eco_label(variant)
        @fuel_options = Hash["A", "-14-55", "B", "-13-33", "C", "-13-11", "D", "-13+11", "E", "-13+33", "F", "-13+55", "G", "-13+77"]
        @wet_options = Hash["A", "+103-53", "B", "+103-31", "C", "+103-9", "D", "+103+13", "E", "+103+35", "F", "+103+56", "G", "+103+78"]
        imagen = variant.images.first
        fuel = variant.tire_fuel_consumption.name
        wet = variant.tire_wet_grip.name
        noise_db = variant.tire_rolling_noise_db
        noise_wave = variant.tire_rolling_noise_wave
        image = MiniMagick::Image.open(imagen.attachment.path(:ceelabel))
        result = image.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/#{fuel.downcase}.png"), "png") do |c|
          c.gravity "center"
          c.geometry @fuel_options[fuel]
        end
        result = result.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/#{wet.downcase}.png", "png")) do |c|
          c.gravity "center"
          c.geometry @wet_options[wet]
        end
        result = result.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/emision_ruido_#{noise_wave}.png", "png")) do |c|
          c.gravity "center"
          c.geometry "-30+165"
        end
        result.combine_options do |c|
          c.gravity "center"
          c.pointsize '30'
          c.draw "text 60,168 '#{noise_db}'"
          c.font 'arial'
          c.fill "#FFFFFF"
        end
        result.write(imagen.attachment.path(:ceelabel))
      end
    end
  end
end
