module Spree
  module Admin
    class TireSerialsController < ResourceController

      def index
        params[:q] ||= {}
        params[:q] ||= "name asc"
        @search = Spree::TireSerial.ransack(params[:q])
        @tire_serials = @search.result.page(params[:page]).per(10)
        respond_to do |format|
          format.html # index.html.erb
          format.js 
        end
      end

    end
  end
end 
