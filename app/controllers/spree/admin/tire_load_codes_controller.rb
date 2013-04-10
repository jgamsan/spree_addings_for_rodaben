module Spree
  module Admin
    class TireLoadCodesController < ResourceController

      def index
        params[:q] ||= {}
        params[:q] ||= "name asc"
        @search = Spree::TireLoadCode.ransack(params[:q])
        @tire_load_codes = @search.result.page(params[:page]).per(10)
        respond_to do |format|
          format.html # index.html.erb
          format.js 
        end
      end

    end
  end
end 
