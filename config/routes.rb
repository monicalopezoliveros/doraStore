Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :show]
  # Defines the root path route ("/")
  # root "articles#index"

  root "products#index"

  get '/pages/:title', to: 'pages#show', as: 'page'

  get 'about', to: 'pages#about', as: :about

end
