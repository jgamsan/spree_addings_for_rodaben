module Spree
  module Admin
    class TireSerialsController < ResourceController
      
      def index
        @tire_serials = Spree::TireSerial.order('name').page(params[:page]).per(10)
      end
      
    end
  end
end 

