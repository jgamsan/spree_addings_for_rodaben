module Spree
  module Admin
    class TireWidthsController < ResourceController

      def index
        params[:q] ||= {}
        @search = Spree::TireWidth.ransack(params[:q])
        @tire_widths = @search.order("name").page(params[:page]).per(10)

      end

    end
  end
end 
