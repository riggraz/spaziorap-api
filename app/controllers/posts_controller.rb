class PostsController < ApplicationController
  before_action :authenticate_user_from_token!, only: [:create]

  # GET /topics/:id/posts
  def index
    if !params[:topic_id].nil?
      @posts = Topic.find(params[:topic_id]).posts.order(created_at: :desc)
    elsif !params[:user_id].nil?
      @posts = User.find(params[:user_id]).posts.order(created_at: :desc)
    end

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

  # GET /posts/latest
  def latest
    n = 50
    
    @posts = Post.order(created_at: :desc).limit(n)
    render json: PostSerializer.new(@posts).serialized_json
  end

  
  private

    def post_params
      params.require(:post).permit(:title, :body, :url, :topic_id).merge(user_id: current_user.id)
    end
end
