Deface::Override.new(:virtual_path => %q{spree/products/_cart},
                     :name => %q{replace_product_price},
                     :replace => %q{div#product-price},
                     :text => %q{
      <h6 class="product-section-title"><%= t(:price) %></h6>
      <% if (@product.price - @product.price_in_offert) < 0 %>
        <div>
          <span class="price selling" style="color:red">
            <%= number_to_currency @product.price %>
          <span class="price selling" itemprop="price" style="text-decoration: line-through;>
            <%= number_to_currency @product.price_in_offert %>
          </span>
        </div>
      <% else %>
        <div>
          <span class="price selling" itemprop="price">
            <%= number_to_currency @product.price %>
          </span>
        </div>})
