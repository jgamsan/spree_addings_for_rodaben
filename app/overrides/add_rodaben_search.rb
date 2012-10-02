Deface::Override.new(:virtual_path => "spree/shared/_nav_bar",
                     :name => "add_rodaben_search",
                     :insert_bottom => "li#search-bar",
                     :text => %q{
<li id="tires-search-bar" data-hook>
    <%= form_tag products_path, :method => :get do -%>
      <%= render :partial => 'spree/shared/search_tires' %>
      <%= submit_tag t(:search), :name => nil %>
<% end -%>})
