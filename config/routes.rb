Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :frontend do
    root to: 'maps#index'
  end

end
