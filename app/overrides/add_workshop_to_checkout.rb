Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                      :name => "add_workshop_to_checkout",
                      :insert_before => "code[erb-loud]:contains('if @order.has_step?('delivery')')",
                      :text => %q{
    <div class="columns alpha four">
    <h6><%= t(:workshop) %> <%= link_to "(#{t(:edit)})", checkout_state_path(:workshop) unless @order.completed? %></h6>
    <div class="address">
      <%= order.workshop %>
    </div>
  </div>})
