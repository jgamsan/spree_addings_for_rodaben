Spree::Core::Engine.routes.draw do
  resources :calc_tires, :only => [:index] do
    collection do
      get 'calc_equivalents'
      get 'search_equivalents'
    end
  end

  resources :about,
    :controller => 'about',
    :only       => [:index]

  namespace :admin do
    resources :tire_settings, :only => :index do
      collection do
        post 'upload_file'
        get 'load_massive_images'
        post 'search_tyre'
      end
    end
    resources :tire_widths
    resources :tire_serials
    resources :tire_innertubes
    resources :tire_speed_codes
  end
  match '/choose_vehicle/:id' => 'home#choose_vehicle'
end
