Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_tab_for_rodaben_admin",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab :tire_settings, :label => 'Gestion Neumaticos' %>")
