module Spree
  module Admin
    class TireWidthsController < ResourceController

      def index
        @tire_widths = Spree::TireWidth.all
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @tire_widths} 
        end 
      end

    end
  end
end 
