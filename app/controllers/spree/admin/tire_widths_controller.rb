module Spree
  module Admin
    class TireWidthsController < Spree::Admin::BaseController
      def index
        @widths = Spree::TireWidth.order("name").page(params[:page]).per(10)
      end
      
      def new
        @width = Spree::TireWidth.new
      end
      
      def edit
        @width = Spree::TireWidth.find(params[:id])      
      end
      
      def create
        @width = Spree::TireWidth.new(params[:width])

        respond_to do |format|
          if @width.save
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Nuevo Ancho creado correctamente.') }
            format.xml  { render :xml => @width, :status => :created, :location => @width }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @width.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def update
        @width = Spree::TireWidth.find(params[:id])

        respond_to do |format|
          if @width.update_attributes(params[:width])
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Ancho actualizado.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @width.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def delete
        @width = Spree::TireWidth.find(params[:id])
        @width.destroy

        respond_to do |format|
          format.html { redirect_to(admin_tire_settings_path) }
          format.xml  { head :ok }
        end
      end
    end
  end
end 

