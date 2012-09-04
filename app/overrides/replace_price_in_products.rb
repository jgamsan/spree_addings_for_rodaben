Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %q{replace_price_in_products},
                     :replace => %q{span.price},
                     :text => %q{
      <% if (product.price - product.price_in_offert) < 0 %>
        <span class="price selling" style="color:red">
          <%= product.display_price %></span>
          <span class="price selling" itemprop="price" style="text-decoration: line-through;">
          <%= product.display_price_in_offert %>
      <% else %>

          <span class="price selling" itemprop="price">
            <%= product.display_price %>
          </span>

      <% end %>})
