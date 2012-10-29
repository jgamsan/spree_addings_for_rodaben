module Spree
  class CalcTiresController < BaseController
    def calc_equivalents
      ancho = Spree::TireWidth.find(params[:width]).name
      perfil = Spree::TireSerial.find(params[:serial]).name
      llanta = Spree::TireInnertube.find(params[:innertube]).name
      @equivalents = (((ancho.to_f/ 25.4) * (perfil.to_f/100) * 2) + llanta.to_f) * 25.4
      respond_to do |format|
        format.js
      end
    end
  end
end
