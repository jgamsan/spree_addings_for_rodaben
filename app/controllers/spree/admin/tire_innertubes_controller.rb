module Spree
  module Admin
    class TireInnertubesController < ResourceController
      
      def index
        @tire_innertubes = Spree::TireInnertube.order('name').page(params[:page]).per(10)
      end
      
    end
  end
end 

