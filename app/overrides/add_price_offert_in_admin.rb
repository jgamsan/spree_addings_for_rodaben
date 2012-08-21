Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                      :name => "add_price_offert_in_admin",
                      :insert_before => "code[erb-loud]:contains('f.field_container :available_on do')",
                      :text => %q{
          <%= f.field_container :price_in_offert do %>
            <%= f.label :price_in_offert, t(:price_in_offert) %><br />
            <%= f.text_field :price_in_offert, :value => number_to_currency(@product.cost_price, :unit => '') %>
            <%= f.error_message_on :cost_price %>
          <% end %>})
