class UsersController < ApplicationController
  before_action :authenticate_user_from_token!, only: [:show]

  # POST /users (create a new user)
  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serialized_json
    else
      render json: { error: I18n.t('user_create_error') }, status: :unprocessable_entity
    end
  end

  # GET /users/:id/verify_access_token (verify access_token of particular user: if successful returns user information)
  def verify_access_token
    auth_token = request.headers['Authorization']
    user_id = auth_token.split(':').first
    
    if user_id == params[:id]
      @user = User.find(user_id)
      render json: UserSerializer.new(@user).serialized_json
    else
      render json: { error: I18n.t('unauthorized') }, status: 401
    end
  end

  # POST /users/push_notification_token (adds Expo's notification token into DB)
  def push_notification_token
    username = params[:user][:username]
    token = params[:token][:value]

    user = User.find_by(username: username)
    user.push_notification_token = token

    if user.save
      render json: { }, status: 204
    else
      render json: { error: I18n.t('push_notification_token_error') }, status: :unprocessable_entity
    end
  end

  # GET /users/:id/score (score of specified User)
  def score
    score = 0
    posts = Post.where(user_id: params[:id])
    posts.each do |post|
      likes = Like.where(post_id: post.id)
      likes.each do |like|
        score += like.score
      end
    end

    render json: score
  end

  
  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
