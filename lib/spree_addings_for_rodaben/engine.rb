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
      Spree::Order.class_eval do
        Spree::Order.state_machines[:state] = StateMachine::Machine.new(Order, :initial => 'cart') do
          event :next do
            transition :from => 'cart',     :to => 'address'
            transition :from => 'address',  :to => 'delivery'
            transition :from => 'delivery', :to => 'payment', :if => :payment_required?
            transition :from => 'delivery', :to => 'complete'
            transition :from => 'confirm',  :to => 'complete'

            # note: some payment methods will not support a confirm step
            transition :from => 'payment',  :to => 'confirm',
                                            :if => Proc.new { |order| order.payment_method && order.payment_method.payment_profiles_supported? }

            transition :from => 'payment', :to => 'complete'
          end

          event :cancel do
            transition :to => 'canceled', :if => :allow_cancel?
          end
          event :return do
            transition :to => 'returned', :from => 'awaiting_return'
          end
          event :resume do
            transition :to => 'resumed', :from => 'canceled', :if => :allow_resume?
          end
          event :authorize_return do
            transition :to => 'awaiting_return'
          end

          before_transition :to => 'complete' do |order|
            begin
              order.process_payments!
            rescue Core::GatewayError
              !!Spree::Config[:allow_checkout_on_gateway_error]
            end
          end

          before_transition :to => ['delivery'] do |order|
            order.shipments.each { |s| s.destroy unless s.shipping_method.available_to_order?(order) }
          end
          around_transition :to => 'complete', :do => :deliver_order_company_provider_email
          after_transition :to => 'complete', :do => :finalize!
          after_transition :to => 'delivery', :do => :create_tax_charge!
          after_transition :to => 'payment',  :do => :create_shipment!
          after_transition :to => 'resumed',  :do => :after_resume
          after_transition :to => 'canceled', :do => :after_cancel

        end
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
