Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_tires_info_to_show",
                     :insert_after => "[data-hook='product_right_part_wrap']",
                     :text => %q{<%= render :partial => 'tires_info' %>})
