Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                     :name => "add_tab_for_rodaben_admin",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab :tires_admin, :label => 'Gestion Neumaticos' %>")
