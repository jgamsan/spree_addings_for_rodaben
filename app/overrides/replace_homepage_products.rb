Deface::Override.new(:virtual_path => %q{spree/home/index},
                          :name => %q{replace_homepage_products},
                          :replace => %q{[data-hook='homepage_products']},
                          :closing_selector => %q{},
                          :text => %q{
            <div data-hook="homepage_products">
            <div id="banner" class="row" data-hook="products_banner">
              <%= render :partial => "spree/shared/banner", :locals => { :cycle_images => @cycle_images } %>
            </div>
            <div id="offerts" class="row" data-hook="products_in_offert">
              <h3>Listado de Productos en Oferta</h3>
              <%= render :partial => 'spree/shared/products', :locals => { :products => @products } %>
            </div>
            </div>               })
