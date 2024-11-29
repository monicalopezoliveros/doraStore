Rails.application.routes.draw do
  # get 'customers/new'
  # get 'customers/create'
  get 'customers/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define rutas para productos
  resources :products, only: [:index, :show]

  # Define rutas para páginas estáticas
  get '/pages/:title', to: 'pages#show', as: 'page'
  get 'about', to: 'pages#about', as: :about

  # Rutas para el carrito
  # resource :cart, only: [:show] do
  #   patch :update, to: 'carts#update_quantity', as: :update
  #   delete :remove, to: 'carts#remove_item', as: :remove
  # end

  # resources :carts, only: [:show] do
  #   post :checkout, to: 'carts#create_order', as: :create_order
  # end

  resource :cart, only: [:show] do
    post :add, to: 'carts#add_to_cart', as: :add_to_cart
    patch :update, to: 'carts#update_quantity', as: :update
    delete :remove, to: 'carts#remove_item', as: :remove
    post :checkout, to: 'carts#create_order', as: :create_order
  end

  # Ruta personalizada para agregar al carrito
  post 'cart/add', to: 'carts#add_to_cart', as: 'add_to_cart'

  # Ruta raíz
  root "products#index"

  get 'checkout', to: 'carts#checkout_form', as: 'checkout'

  resources :customers, only: [:new, :create]
  # get 'checkout', to: 'checkout#index'

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }

  resources :orders, only: [:create, :show]

  get 'contact', to: 'pages#contact', as: :contact

end
