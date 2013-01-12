Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "add_rodaben_specs",
                     :insert_bottom => "#shipping_specs",
                     :text => %q{
        <%= f.field_container :tire_green_rate do %>
  <%= f.label :tire_green_rate_id, t(:green_rate) %><br />
  <%= f.collection_select(:tire_green_rate_id, Spree::TireGreenRate.order('cat'), :id, :cat, { :include_blank => true }, { :class => 'select2', :style => "width:120px;" }) %>
  <%= f.error_message_on :tire_green_rate %>
<% end -%>})
