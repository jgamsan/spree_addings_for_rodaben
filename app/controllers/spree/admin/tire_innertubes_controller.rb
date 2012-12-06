module Spree
  module Admin
    class TireInnertubesController < ResourceController

      def index
        params[:q] ||= {}
        params[:q] ||= "name asc"
        @search = Spree::TireInnertube.ransack(params[:q])
        @tire_innertubes = @search.result.page(params[:page]).per(10)
      end

    end
  end
end 
