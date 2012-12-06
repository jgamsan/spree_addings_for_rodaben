module Spree
  module Admin
    class TireWidthsController < ResourceController

      def index
        params[:q] ||= "name asc"
        @search = Spree::TireWidth.ransack(params[:q])
        @tire_widths = @search.page(params[:page]).per(10)

      end

    end
  end
end 
