module Spree
  module Admin
    class TireSettingsController < Spree::Admin::BaseController
      def search_tyre
        tyre = params[:tyre]
        @searcher = Spree::Config.searcher_class.new(params.merge(:keywords => tyre))
        @products = @searcher.retrieve_products

        respond_to do |format|
          format.js
        end
      end

      def upload_file
        productos = params[:product_ids]
        for product in productos
          t = Spree::Product.find(product)
          unless t.images.empty?
            t.images.destroy_all
          end
          img = Spree::Image.create!({:attachment => params[:image], :viewable => t}, :without_protection => true)
          t.images << img
        end
        redirect_to load_massive_images_admin_tire_settings_url
      end

      def load_massive_images

      end
    end
  end
end
