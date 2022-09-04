Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/search', to: 'searches#index'
  resources :users
  resources :posts
end
