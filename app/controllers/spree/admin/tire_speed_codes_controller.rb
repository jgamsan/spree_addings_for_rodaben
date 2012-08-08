module Spree
  module Admin
    class TireSpeedCodesController < ResourceController
      
      def index
        @tire_speed_codes = Spree::TireSpeedCode.order('name').page(params[:page]).per(10)
      end
      
    end
  end
end 

