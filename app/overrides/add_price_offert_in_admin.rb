Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                      :name => "add_price_offert_in_admin",
                      :insert_before => "code[erb-loud]:contains('f.field_container :available_on do')",
                      :text => %q{
          <%= f.field_container :price_in_offert do %>
            <%= f.label :price_in_offert, t(:price_in_offert) %><br />
            <%= f.text_field :price_in_offert, :value => number_to_currency(@product.price_in_offert, :unit => '') %>
            <%= f.error_message_on :cost_price %>
          <% end %>
          <%= f.label :show_in_offert, t(:show_in_offert) %>
          <%= f.check_box :show_in_offert, { 'style' => 'width:40px' } %>})
