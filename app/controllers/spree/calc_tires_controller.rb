module Spree
  class CalcTiresController < BaseController
    def calc_equivalents
      @equivalentes = []
      ancho = Spree::TireWidth.find(params[:width]).name
      perfil = Spree::TireSerial.find(params[:serial]).name
      llanta = Spree::TireInnertube.find(params[:innertube]).name
      @diametro = calculo_diametro(ancho, perfil, llanta)
      minimum = @diametro * 0.97
      maximum = @diametro * 1.03
      ta = Spree::TireWidth.in_mm(true).map {|c| c.name}
      tp = Spree::TireSerial.in_mm(true).map {|c| c.name}
      tl = Spree::TireInnertube.in_mm(true).map {|c| c.name}
      ta.each do |width|
        tp.each do |serial|
          tl.each do |innertube|
            parcial = calculo_diametro(width, serial, innertube)
            if (parcial <= maximum) && (parcial >= minimum)
              neumatico = ta + "/" + tp + "R" + tl
              @equivalentes << [neumatico, neumatico]
            end
          end
        end
      end


      respond_to do |format|
        format.js
      end
    end

    private

    def calculo_diametro(ancho, perfil, llanta)
      ((((ancho.to_f / 25.4) * (perfil.to_f/100) * 2) + llanta.to_f) * 25.4).round(2)
    end

  end
end
