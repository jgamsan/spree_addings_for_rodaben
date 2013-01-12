Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_tab_for_rodaben_admin",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab :tire_settings, :tire_widths,
                     :tire_innertubes, :tire_serials, :tire_speed_codes, :tire_load_codes, :tire_green_rates,
                     :workshops, :load_massive_images, :search_tires_for_green_rate, :label => 'Gestion Neumaticos', :icon => 'icon-truck', :url => admin_tire_settings_path %>")
