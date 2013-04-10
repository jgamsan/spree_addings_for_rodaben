module Spree
  module Admin
    class TireWidthsController < ResourceController
      def index
        params[:q] ||= {}
        params[:q] ||= "name asc"
        @search = Spree::TireWidth.ransack(params[:q])
        @tire_widths = @search.result.page(params[:page]).per(10)

        respond_to do |format|
          format.html # index.html.erb
          format.js 
        end
      end
    end
  end
end 
