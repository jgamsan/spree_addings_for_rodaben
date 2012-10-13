Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %q{add_tires_info_in_products},
                     :replace => "ul#products",
                     :text => %q{
   <ul id="products" class="inline product-listing" data-hook>
  <% reset_cycle('default') %>
  <% products.each do |product| %>
    <% if Spree::Config[:show_zero_stock_products] || product.has_stock? %>
      <li id="product_<%= product.id %>" class="columns three <%= cycle("alpha", "secondary", "", "omega secondary", :name => "classes") %>" data-hook="products_list_item" itemscope itemtype="http://schema.org/Product">
        <div class="product-image">
          <%= link_to small_image(product, :itemprop => "image"), product, :itemprop => 'url' %>
        </div>
        <%= link_to truncate(product.name, :length => 50), product, :class => 'info', :itemprop => "name", :title => product.name %>
        <br> <%= product.calculate_tires(product.id) %>
        <% if (product.price - product.price_in_offert) < 0 %>
        <span class="price selling" style="color:red">
          <%= product.display_price %></span>
          <span class="price selling" itemprop="price" style="text-decoration: line-through;">
          <%= product.display_price_in_offert %>
      <% else %>

          <span class="price selling" itemprop="price">
            <%= product.display_price %>
          </span>

      <% end %>
      </li>
    <% end %>
  <% end %>
  <% reset_cycle("classes") %>
</ul>})
