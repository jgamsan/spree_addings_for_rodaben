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
        imagen = params[:image]
        type = imagen.split(".").last
        for product in productos
          t = Spree::Product.find(product)
          i = Spree::Image.new
          i.attachment = imagen
          i.viewable = t.master
          i.save
        end

      end

      def load_massive_images

      end
    end
  end
end
