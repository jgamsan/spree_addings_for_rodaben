Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_tab_for_rodaben_admin",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab :tire_settings, :tire_widths,
                     :tire_innertubes, :tire_serials, :tire_speed_codes,
                      :workshops, :load_massive_images, :label => 'Gestion Neumaticos', :icon => 'icon-truck' %>")
