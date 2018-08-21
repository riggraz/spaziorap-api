class UsersController < ApplicationController
  # POST /users (create a new user)
  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serialized_json
    else
      render json: { error: I18n.t('user_create_error') }, status: :unprocessable_entity
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
