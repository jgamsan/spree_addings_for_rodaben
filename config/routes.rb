Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :tire_settings, :only => :index
    resources :tire_widths
    resources :tire_serials
    resources :tire_innertubes
    resources :tire_speed_codes
  end
end
