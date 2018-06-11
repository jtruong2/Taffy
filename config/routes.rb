Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/user/:user_id", to: 'users#show'
      post "/user", to: 'users#create'
      patch "/user/:user_id", to: 'users#update'

      post "/login", to: 'sessions#create'
      delete "/logout", to: 'sessions#destroy'
      get "/current_user", to: 'sessions#show'

      get "/user/:user_id/post", to: 'posts#index'
      get "/user/:user_id/post/:post_id", to: 'posts#show'
      post "/user/:user_id/post", to: 'posts#create'
    end
  end
end
