class PostsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

  #GET /posts
  def index
    n = 50
    
    @posts = Post.order(created_at: :desc).limit(n)
    render json: PostSerializer.new(@posts).serialized_json
  end
end
