module SpreeAddingsForRodaben
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_addings_for_rodaben\n"
        append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_addings_for_rodaben\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_addings_for_rodaben\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_addings_for_rodaben\n", :before => /\*\//, :verbose => true
      end

      def add_datas
        run 'mkdir db/default' unless Dir.exist?('db/default')
        copy_file "tire_widths.yml", "db/default/spree/tire_widths.yml"
        copy_file "tire_innertubes.yml", "db/default/spree/tire_innertubes.yml"
        copy_file "tire_serials.yml", "db/default/spree/tire_serials.yml"
        copy_file "tire_speed_codes.yml", "db/default/spree/tire_speed_codes.yml"
        copy_file "states.yml", "db/default/spree/states.yml"
        copy_file "taxons.yml", "db/default/spree/taxons.yml"
        copy_file "suppliers.yml", "db/default/spree/suppliers.yml"
        copy_file "taxonomies.yml", "db/default/spree/taxonomies.yml"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_addings_for_rodaben'
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts 'Skipping rake db:migrate, don\'t forget to run it!'
         end
      end
    end
  end
end
