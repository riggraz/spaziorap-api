Rails.application.routes.draw do
  devise_for :users, only: []

  ### Users ###
  # POST /users (registration)
  resources :users, only: [:create] do
    # GET /users/:id/posts (Posts of specified User)
    resources :posts, only: [:index]

    # GET /users/:id/notifications (Notifications of specified User)
    resources :notifications, only: [:index]

    # GET /users/:id/score (score of specified User)
    get 'score', on: :member

    # GET /users/:id/verify_access_token (verify the access_token of specified User)
    get :verify_access_token, on: :member
  end
  # resource :verify_access_token, only: [:show], controller: :users

  # POST /login (login)
  resource :login, only: [:create], controller: :sessions

  ### Topics ###
  # GET /topics (list of all Topics)
  resources :topics, only: [:index] do
    # GET /topics/:id/posts (Posts of specified Topic)
    resources :posts, only: [:index]
  end

  ### Posts ###
  # GET /posts/:id (specified Post)
  # POST /posts (create a Post)
  # DELETE /posts/:id (delete specified Post)
  resources :posts, only: [:show, :create, :destroy] do
    # GET /posts/latest (last 50 Posts)
    get 'latest', on: :collection

    ### Likes ###
    # POST /posts/:id/likes (create or update Like of specified Post)
    resources :likes, only: [:create]

    ### Comments ###
    # GET /posts/:id/comments (Comments of specified Post)
    # POST /posts/:id/comments (create Comment for specified Post)
    resources :comments, only: [:index, :create]
  end

  resources :comments, only: [] do
    resources :likes, only: [:create]
  end

  ### Songs ###
  # GET /songs
  resources :songs, only: [] do
    get 'latest', on: :collection
  end

  ### Artists ###
  # GET /artists
  resources :artists, only: [:index]

  # POST /notifications/:id/mark_as_read (mark specified Notification as read)
  resources :notifications, only: [] do
    post 'mark_as_read', on: :member
  end
end
