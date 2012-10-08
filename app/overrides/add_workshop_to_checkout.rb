Deface::Override.new(:virtual_path => "spree/checkout/_delivery",
                      :name => "add_workshop_to_checkout",
                      :insert_after => "fieldset#shipping_method",
                      :text => %q{
    <fieldset id='shipping_method' data-hook>
  <legend><%= t(:workshop_options) %></legend>
  <div class="inner" data-hook="workshop_options_inner">
    <div id="options">
      <p class="field radios">
        <%= radio_button(:order, "workshop", 99999) %>
        "No enviar a Taller" <%#= workshop.display_price %>
        <% Spree::Workshop.all.each do |workshop| %>
          <label>
            <%= radio_button(:order, :workshop, workshop[:id]) %>
            <%= workshop.name %> <%#= workshop.display_price %>
          </label>
        <% end %>
      </p>
    </div>
  </div>
</fieldset>})
