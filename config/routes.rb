Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :admin_tires
  end
end
