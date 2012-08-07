module Spree
  module Admin
    class TireSerialsController < Spree::Admin::BaseController
      def index
        @serials = Spree::TireSerial.order('name').page(params[:page]).per(10)
      end
      
      def new
        @serial = Spree::TireSerial.new
      end
      
      def edit
        @serial = Spree.TireSerial(params[:id])      
      end
      
      def create
        @serial = Spree::TireSerial.new(params[:serial])

        respond_to do |format|
          if @serial.save
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Nueva Serie creada correctamente.') }
            format.xml  { render :xml => @serial, :status => :created, :location => @serial }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @serial.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def update
        @serial = Spree::TireSerial.find(params[:id])

        respond_to do |format|
          if @serial.update_attributes(params[:serial])
            format.html { redirect_to(admin_tire_settings_path, :notice => 'Ancho actualizado.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @serial.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      def delete
        @serial = Spree::TireSerial.find(params[:id])
        @serial.destroy

        respond_to do |format|
          format.html { redirect_to(admin_tire_settings_path) }
          format.xml  { head :ok }
        end
      end
    end
  end
end 

