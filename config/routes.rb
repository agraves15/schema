Rails.application.routes.draw do
  get '/' => 'welcome#index'

  resources :colors
  resources :schemes
  resources :users

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  delete '/logout' => 'sessions#destroy'

  get '/schemes/:id/share' => 'schemes#share', as: :share_scheme
  post '/schemes/:id/share' => 'schemes#share_with_user', as: :share_with_user
  post '/schemes/:id/unshare' => 'schemes#unshare_with_user', as: :unshare

  post '/users/:id/request' => 'users#request_friend', as: :request_friend
  post '/users/:id/accept' => 'users#accept_friend', as: :accept_friend
  post '/users/:id/decline' => 'users#decline_friend', as: :decline_friend
end
