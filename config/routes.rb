Rails.application.routes.draw do
  devise_for :users, only: []
  resource :login, only: [:create], controller: :sessions
end
