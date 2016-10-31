Rails.application.routes.draw do

  devise_for :user, controllers: {
    sessions:      'backend/devise/sessions',
    passwords:     'backend/devise/passwords',
    confirmations: 'backend/devise/confirmations',
    registrations: 'backend/devise/registrations',
  }

  devise_scope :user do
    get  '/sign_in', to: 'backend/devise/sessions#new',      as: 'sign_in'
    get  '/sign_up', to: 'backend/devise/registrations#new', as: 'sign_up'
  end

  scope module: :frontend do
    root to: 'webs#index'

    get '/maps/:map_id/dots', to: 'webs#dots', as: :front_map_dots
  end

  scope "/admin", module: :backend do
    get '/', to: 'maps#index'

    resources :maps do
      resources :upload_maps, only: [:new, :create]
      resources :dots
    end
  end

end
