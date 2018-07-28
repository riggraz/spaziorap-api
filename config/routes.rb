Rails.application.routes.draw do
  devise_for :users, only: []

  ### Auth ###
  # POST /users (registration)
  resources :users, only: [:create] do
    # GET /users/:id/posts (Posts of specified User)
    resources :posts, only: [:index]
  end

  # POST /login (login)
  resource :login, only: [:create], controller: :sessions

  ### Topic ###
  # GET /topics (list of all Topics)
  resources :topics, only: [:index] do
    # GET /topics/:id/posts (Posts of specified Topic)
    resources :posts, only: [:index]
  end

  ### Post ###
  # GET /posts/:id (specified Post)
  # POST /posts (create a Post)
  resources :posts, only: [:show, :create] do
    # GET /posts/latest (last 50 Posts)
    get 'latest', on: :collection
  end
end
