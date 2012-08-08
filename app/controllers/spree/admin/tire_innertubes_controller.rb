module Spree
  module Admin
    class TireInnertubesController < Spree::Admin::BaseController
      def index
        @innertubes = Spree::TireInnertube.order('name').page(params[:page]).per(10)
      end
      
      def new
        @innertube = Spree::TireInnertube.new
      end
      
      def edit
        @innertube = Spree::TireInnertube.find(params[:id])      
      end
      
      def create
        @innertube = Spree::TireInnertube.new(params[:innertube])

        respond_to do |format|
          if @innertube.save
            format.html { redirect_to(admin_tire_innertubes_path, :notice => 'Nueva Llanta creada correctamente.') }
            format.xml  { render :xml => @innertube, :status => :created, :location => @innertube }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @innertube.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def update
        @innertube = Spree::TireInnertube.find(params[:id])

        respond_to do |format|
          if @innertube.update_attributes(params[:innertube])
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Llanta actualizado.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @innertube.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def delete
        @innertube = Spree::TireInnertube.find(params[:id])
        @innertube.destroy

        respond_to do |format|
          format.html { redirect_to(admin_tire_settings_path) }
          format.xml  { head :ok }
        end
      end
    end
  end
end 

