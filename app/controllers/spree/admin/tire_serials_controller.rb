module Spree
  module Admin
    class TireSerialsController < ResourceController

      def index
        params[:q] ||= {}
        params[:q] ||= "name asc"
        @search = Spree::TireSerial.ransack(params[:q])
        @tire_serials = @search.result.page(params[:page]).per(10)
      end

    end
  end
end 
