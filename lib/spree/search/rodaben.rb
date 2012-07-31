module Spree::Search
  class Rodaben < Spree::Core::Search::Base
    def get_base_scope
      base_scope = Spree::Product.active
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?
      base_scope = base_scope.by_width(tire_width_id.to_i) if tire_width_id
      base_scope = base_scope.by_serial(tire_serial_id.to_i) if tire_serial_id
      base_scope = base_scope.by_innertube(tire_innertube_id.to_i) if tire_innertube_id
      base_scope = base_scope.by_speed(tire_speed_code_id.to_i) if tire_speed_code_id
      base_scope = base_scope.by_rf(tire_rf) if tire_rf
      base_scope = base_scope.by_gr(tire_gr) if tire_gr
      base_scope = base_scope.by_season(tire_season.to_i) if tire_season
      base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
      base_scope = add_search_scopes(base_scope)
      base_scope
    end
    
    def prepare(params)
      @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
      @properties[:keywords] = params[:keywords]
      @properties[:search] = params[:search]

      per_page = params[:per_page].to_i
      @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
      @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
      @properties[:tire_width_id] = params[:tire_width_id].blank? ? nil : params[:tire_width_id]
      @properties[:tire_season_id] = params[:tire_season_id].blank? ? nil : params[:tire_season_id]
      @properties[:tire_innertube_id] = params[:tire_innertube_id].blank? ? nil : params[:tire_innertube_id]
      @properties[:tire_speed_code_id] = params[:tire_speed_code_id].blank? ? nil : params[:tire_speed_code_id]
      @properties[:tire_gr] = params[:tire_gr].blank? ? nil : params[:tire_gr]
      @properties[:tire_rf] = params[:tire_rf].blank? ? nil : params[:tire_rf]
      @properties[:tire_season] = params[:tire_season].blank? ? nil : params[:tire_season]
    end
  end
end
