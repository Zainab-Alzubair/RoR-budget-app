Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :groups, only: [:new, :create, :index, :show, :destroy] do
    resources :payments, only: [:new, :create, :index, :show, :destroy]
  end
  root "groups#index"
end