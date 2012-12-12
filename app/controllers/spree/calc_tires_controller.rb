module Spree
  class CalcTiresController < BaseController
    layout "contenido"
    helper 'spree/products'
    respond_to :html
    def index
      vehiculo = params[:vehicle]
      if params[:lista].blank?
        innertube = params[:llanta]
        llanta = Spree::TireInnertube.find_by_name(innertube).id
        @searcher = Spree::Config.searcher_class.new(params.merge(:tire_innertube_id => llanta, :vehicle => vehiculo)) 
      else
        rueda = params[:lista]
        rueda =~ %r{(\d+)(?:/|:)(\d+)(?:\D|:)(\d+)}
        r = [$1,$2,$3]
        ancho = Spree::TireWidth.find_by_name(r[0]).id
        serial = Spree::TireSerial.find_by_name(r[1]).id
        llanta = Spree::TireInnertube.find_by_name(r[2]).id
        @searcher = Spree::Config.searcher_class.new(params.merge(:tire_width_id => ancho, :tire_serial_id => serial, :tire_innertube_id => llanta, :vehicle => vehiculo))           
      end
      @products = @searcher.retrieve_products
      respond_with(@products)
    end

    def method_name
      
    end

    def show_options
      @widths = Spree::TireWidth.in_mm(true).map {|t| [t.name, t.id]}
      @serials = Spree::TireSerial.in_mm(true).map {|t| [t.name, t.id]}
      @innertubes = Spree::TireInnertube.in_mm(true).map {|t| [t.name, t.id]}
    end

    def calc_equivalents
      @equivalentes = []
      @innertubes = []
      ancho = Spree::TireWidth.find(params[:width]).name
      perfil = Spree::TireSerial.find(params[:serial]).name
      llanta = Spree::TireInnertube.find(params[:innertube]).name
      @diametro = calculo_diametro(ancho, perfil, llanta)
      minimum = @diametro * 0.97
      maximum = @diametro * 1.03
      ta = Spree::TireWidth.in_mm(true).by_taxon(4).map {|c| c.name}
      tp = Spree::TireSerial.in_mm(true).by_taxon(4).map {|c| c.name}
      tl = Spree::TireInnertube.in_mm(true).by_taxon(4).map {|c| c.name}
      ta.each do |width|
        tp.each do |serial|
          tl.each do |innertube|
            parcial = calculo_diametro(width, serial, innertube)
            if (parcial <= maximum) && (parcial >= minimum)
              neumatico = width + "/" + serial + "R" + innertube
              @equivalentes << [neumatico, neumatico] if existe_neumatico?(width, serial, innertube)
              @innertubes << [innertube, innertube]
            end
          end
        end
      end
      respond_to do |format|
        format.js
      end
    end

    def search_equivalents
      rueda = params[:lista]
      rueda =~ %r{(\d+)(?:/|:)(\d+)(?:\D|:)(\d+)}
      r = [$1,$2,$3]
      ancho = Spree::TireWidth.find_by_name(r[0]).id
      serial = Spree::TireSerial.find_by_name(r[1]).id
      llanta = Spree::TireInnertube.find_by_name(r[2]).id
      @searcher = Spree::Config.searcher_class.new(params.merge(:tire_width_id => ancho, :tire_serial_id => serial, :tire_innertube_id => llanta))
      @products = @searcher.retrieve_products
      render :partial => "spree/shared/products", :locals => { :products => @products}
    end

    private

    def calculo_diametro(ancho, perfil, llanta)
      ((((ancho.to_f / 25.4) * (perfil.to_f/100) * 2) + llanta.to_f) * 25.4).round(2)
    end

    def existe_neumatico?(ancho, perfil, llanta)
      width = Spree::TireWidth.find_by_name(ancho)
      serial = Spree::TireSerial.find_by_name(perfil)
      innertube = Spree::TireInnertube.find_by_name(llanta)
      w = width.id
      s = serial.id
      i = innertube.id
      true unless Spree::Product.by_width(w).by_serial(s).by_innertube(i).empty?
    end

  end
end
