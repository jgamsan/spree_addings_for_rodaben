Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "add_rodaben_specs",
                     :insert_bottom => "#shipping_specs",
                     :text => %q{ <%= render :partial => "spree/admin/products/tires", :locals => {:f => f} %> })
