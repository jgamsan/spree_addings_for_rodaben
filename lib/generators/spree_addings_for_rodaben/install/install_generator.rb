module SpreeAddingsForRodaben
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_addings_for_rodaben\n"
        append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_addings_for_rodaben\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_addings_for_rodaben\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_addings_for_rodaben\n", :before => /\*\//, :verbose => true
      end
      
      def add_datas
        run 'mkdir db/datas' unless Dir.exist?('db/datas')
        copy_file "anchos.csv", "db/datas/rodaben-anchos.csv"
        copy_file "llantas.csv", "db/datas/rodaben-llantas.csv"
        copy_file "perfiles.csv", "db/datas/rodaben-series.csv"
        copy_file "vel.csv", "db/datas/rodaben-ivel.csv"
        copy_file "marcas.csv", "db/datas/rodaben-marcas.csv"
        copy_file "taxons.csv", "db/datas/rodaben-taxons.csv"
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
