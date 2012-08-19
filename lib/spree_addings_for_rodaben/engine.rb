module SpreeAddingsForRodaben
  class Engine < Rails::Engine
    require 'spree/core'
    engine_name 'spree_addings_for_rodaben'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Spree::Config.searcher_class = Spree::Search::Rodaben
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Order.class_eval do
        Order.state_machines[:state] = StateMachine::Machine.new(Order, :initial => 'cart') do
          around_transition :to => 'complete', :do => :deliver_order_company_provider_email
        end
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
