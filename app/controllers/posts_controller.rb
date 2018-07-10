class PostsController < ApplicationController
  before_action :authenticate_user_from_token!, only: [:create]

  # GET /posts
  def index
    n = 50
    
    @posts = Post.order(created_at: :desc).limit(n)
    render json: PostSerializer.new(@posts).serialized_json
  end

  # GET /posts/:id
  def show
    @post = Post.find(params[:id])
    render json: PostSerializer.new(@post).serialized_json
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: PostSerializer.new(@post).serialized_json
    else
      render json: { error: I18n.t('post_create_error') }, status: :unprocessable_entity
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :url, :topic_id).merge(user_id: current_user.id)
    end
end
