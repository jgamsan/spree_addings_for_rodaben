Deface::Override.new(:virtual_path => "spree/shared/_nav_bar",
                     :name => "add_rodaben_search",
                     :insert_bottom => "li#search-bar",
                     :text => %q{
<li id="category-check-bar" data-hook>
  <%= render :partial => "spree/shared/type_category" %>
</li>
<li id="tires-search-bar" data-hook>
    <%= form_tag products_path, :method => :get do -%>
      <div id="searchTyres">
        <%= render :partial => 'spree/shared/search_tires' %>
      </div>
      <%= submit_tag t(:search), :name => nil %>
<% end -%>})
