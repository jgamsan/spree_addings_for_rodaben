module Spree
  module Admin
    class TireSpeedCodesController < Spree::Admin::BaseController
      def index
        @speed_codes = Spree::TireSpeedCode.all.order('name').page(params[:page]).per(10)
      end
      
      def new
        @speed_code = Spree::TireSpeedCode.new
      end
      
      def edit
        @speed_code = Spree.TireSpeedCode(params[:id])      
      end
      
      def create
        @speed_code = Spree::TireSpeedCode.new(params[:speed_code])

        respond_to do |format|
          if @speed_code.save
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Nuevo Codigo Velocidad creado correctamente.') }
            format.xml  { render :xml => @speed_code, :status => :created, :location => @speed_code }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @speed_code.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def update
        @speed_code = Spree::TireSpeedCode.find(params[:id])

        respond_to do |format|
          if @speed_code.update_attributes(params[:speed_code])
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Codigo Velocidad actualizado.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @speed_code.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def delete
        @speed_code = Spree::TireSpeedCode.find(params[:id])
        @speed_code.destroy

        respond_to do |format|
          format.html { redirect_to(admin_tire_settings_path) }
          format.xml  { head :ok }
        end
    end
  end
end 

