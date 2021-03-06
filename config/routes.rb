Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#welcome"
  post '/', to: "sessions#create"
  post '/signout', to: "sessions#destroy"
  get '/signup', to: "users#new"
  post '/dashboard', to: "users#create"
  patch '/dashboard', to: "users#update"
  get '/dashboard', to: "users#show"
  get '/items/all', to: "items#index"
  get '/cart', to: "carts#cart"
  get '/items/new', to: "items#new"
  post '/items/all', to: 'items#create'
  # patch '/categories/:category_id/items/:id', to: "items#update"
  get '/cart', to: "carts#index"
  post '/checkout', to: "carts#checkout"
  get '/carts/:id', to: "carts#destroy"
  get '/inventory', to: "users#inventory"
  # post '/delete_item', to: "items#destroy"

  resources :users, only: [:edit] do
    resources :addresses, only: [:edit, :update]
  end

  resources :carts, only: [:new, :create, :show, :edit, :update] do
    member do
      post 'empty'
    end
  end

  resources :categories, only: [:show] do
    resources :items, except: [:index] do
      member do
        post 'add_to_cart'
      end
      resources :reviews, only: [:index]
    end
  end
end
