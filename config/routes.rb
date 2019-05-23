Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  #get '/users/new', to: 'users#new'
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'
  #get 'static_pages/home'
  #get '/help', to: 'static_pages#help', as: 'helf'
  get '/help', to: 'static_pages#help'
  #get 'static_pages/help'
  get '/about', to: 'static_pages#about'
  #get 'static_pages/about'
  get '/contact', to: 'static_pages#contact'
  #get 'static_pages/contact'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

resources :users

resources :account_activations, only: [:edit]

resources :password_resets,     only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'application#hello'
end
