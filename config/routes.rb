Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index', to: 'posts#index'
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
    resources :likes, only: %i[create destroy]
  end
  resources :users do
    resources :bookmarks, only: [:index]
    resources :likes, only: [:index]
  end
  # namespace :api, { format: 'json' } do
  #   namespace :v1 do
  #     resources :posts, only: %i[index show new create update]
  #   end
  # end
end
