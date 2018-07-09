Rails.application.routes.draw do
  devise_for :users, only: []
  resource :login, only: [:create], controller: :sessions

  resources :topics, only: [:index]
  resources :posts, only: [:index]
end
