Deface::Override.new(:virtual_path => %q{spree/payment/_address},
                     :name => %q{add_workshop_to_order},
                     :isert_before => %q{p#scity},
                     :text => %q{
                     <p class="field" id="scity">
        <%= ship_form.label :workshop, t(:workshop) %><span class="required">*</span><br />
        <%= ship_form.select :workshop, options_for_select([['No, a mi domicilio', 99999]] +
                Spree::Workshop.order('name').map {|t| [t.name, t.id]}) %>
      </p>})
