Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                     :name => "add_tab_for_rodaben_admin",
                     :insert_bottom => nil,
                     :text => "<%= tab :tires_admin, :label => 'Gestion Neumaticos' %>")
