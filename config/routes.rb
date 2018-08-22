Rails.application.routes.draw do
  devise_for :users, only: []

  ### User ###
  # POST /users (registration)
  resources :users, only: [:create] do
    # GET /users/:id/posts (Posts of specified User)
    resources :posts, only: [:index]

    # GET /users/:id/score (score of specified User)
    get 'score', on: :member
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
  # DELETE /posts/:id (delete specified Post)
  resources :posts, only: [:show, :create, :destroy] do
    # GET /posts/latest (last 50 Posts)
    get 'latest', on: :collection

    # GET /posts/:id/likes (Likes of specified Post)
    resources :likes, only: [:index]
    # POST /posts/:id/likes (create or update Like of specified Post)
    resources :likes, only: [:create]
  end

  ### Songs ###
  # GET /songs
  resources :songs, only: [:index]
end
