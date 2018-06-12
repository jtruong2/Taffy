Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/user/:user_id",                       to: 'users#show'
      post "/user",                               to: 'users#create'
      patch "/user/:user_id",                     to: 'users#update'

      post "/login",                              to: 'sessions#create'
      delete "/logout",                           to: 'sessions#destroy'
      get "/current_user",                        to: 'sessions#show'

      get "/user/:user_id/post",                  to: 'posts#index'
      get "/user/:user_id/post/:post_id",         to: 'posts#show'
      post "/user/:user_id/post",                 to: 'posts#create'
      patch "/user/:user_id/post/:post_id",       to: 'posts#update'
      delete "/user/:user_id/post/:post_id",      to: 'posts#destroy'

      post "/user/:user_id/post/:post_id/like",      to: 'likes#create'
      delete "/user/:user_id/post/:post_id/like",    to: 'likes#destroy'
      get "/user/:user_id/post/:post_id/check_like", to: 'likes#show'
    end
  end
end
