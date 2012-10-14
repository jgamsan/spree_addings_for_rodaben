Deface::Override.new(:virtual_path => "spree/shared/_main_nav_bar",
                     :name => "add_about_in_header",
                     :insert_bottom => "#main-nav-bar",
                     :text => "<li class='<%= (request.fullpath.gsub('//','/') == '/about') ? 'current' : 'not'%>'><%= link_to t('spree.about'), about_index_url  %></li>")
