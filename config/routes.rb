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
  end

  scope "/admin", module: :backend do
    get '/', to: 'maps#index'

    resources :maps
    resources :users
  end

end
