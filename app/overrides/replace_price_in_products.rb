Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %q{replace_price_in_products},
                     :replace => %q{span.price},
                     :text => %q{
      <% if (product.price - product.price_in_offert) < 0 %>
        <span class="price selling" style="color:red">
          <%= number_to_currency product.price %></span>
          <span class="price selling" itemprop="price" style="text-decoration: line-through;">
          <%= number_to_currency product.price_in_offert %>
      <% else %>

          <span class="price selling" itemprop="price">
            <%= number_to_currency product.price %>
          </span>

      <% end %>})
