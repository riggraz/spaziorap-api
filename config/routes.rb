Rails.application.routes.draw do
  devise_for :users, only: []

  resources :users, only: [:create]
  resource :login, only: [:create], controller: :sessions

  resources :topics, only: [:index]
  resources :posts, only: [:index, :show, :create]

  #add posts by topic
end
