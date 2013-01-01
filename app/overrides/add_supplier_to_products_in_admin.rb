Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                      :name => "add_supplier_to_products_in_admin",
                      :insert_bottom => %q{[data-hook='admin_product_form_left']},
                      :text => %q{
          <%= f.field_container :supplier do %>
        <%= f.label :supplier_id, t(:supplier_id) %><br />
        <%= f.collection_select(:supplier_id, Spree::Supplier.all, :id, :name, { :include_blank => true }, { :class => 'select2', :style => "width:120px;" }) %>
        <%= f.error_message_on :supplier_id %>
      <% end %>
      })
