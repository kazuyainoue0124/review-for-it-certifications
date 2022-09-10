Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root 'posts#index'
  get 'posts/index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/search', to: 'searches#index'
  resources :users
  resources :posts
  resources :users do
    resource :relationships, only: %i[create destroy]
    get '/followings' => 'relationships#followings', as: 'followings'
    get '/followers' => 'relationships#followers', as: 'followers'
  end
  resources :posts do
    resources :bookmarks, only: %i[create destroy]
  end
  resources :users do
    resources :bookmarks, only: [:index]
  end
end
