module Spree
  module Admin
    class TireSpeedCodesController < ResourceController

      def index
        params[:q] ||= {}
        params[:q] ||= "name asc"
        @search = Spree::TireSpeedCode.ransack(params[:q])
        @tire_speed_codes = @search.result.page(params[:page]).per(10)
      end

    end
  end
end 
