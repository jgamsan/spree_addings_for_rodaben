Spree::Core::Engine.routes.draw do
  namespace :admin do
    resource :tire_settings, :only => :index
    resource :tire_widths
    resource :tire_serials
    resource :tire_innertubes
    resource :tire_speed_codes
  end
end
