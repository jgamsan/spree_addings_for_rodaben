module Spree
  module Admin
    class TireWidthsController < ResourceController

      def index
        @tire_widths = Spree::TireWidth.order("name").page(params[:page]).per(10)
      end
    
    end
  end
end 

