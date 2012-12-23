Spree::Core::Engine.routes.draw do
  resources :calc_tires, :only => [:index] do
    collection do
      get 'show_options'
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
        get 'search_tyre'
        post 'search_tyre'
        post 'assign_massive_green_rate'
        get 'assign_massive_green_rate'
        get 'search_tires_for_green_rate'
        post 'load_green_rate'
      end
    end
    resources :tire_widths
    resources :tire_serials
    resources :tire_innertubes
    resources :tire_speed_codes
    resources :tire_load_codes
  end
end
