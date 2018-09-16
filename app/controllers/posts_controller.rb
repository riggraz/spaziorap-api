class PostsController < ApplicationController
  before_action :authenticate_user_from_token!, only: [:create, :destroy]

  # GET /topics/:id/posts?page=n
  # GET /users/:id/posts?page=n
  def index
    @posts = nil

    if !params[:topic_id].nil?
      @posts = Topic.find(params[:topic_id]).posts
    elsif !params[:user_id].nil?
      @posts = User.find(params[:user_id]).posts
    end

    @posts = @posts.order(created_at: :desc).page(params[:page]).per(10)    
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

  # DELETE /posts/:id
  def destroy
    @post = Post.find(params[:id])

    if current_user.admin
      @post.destroy
      render json: PostSerializer.new(@post).serialized_json
    else
      render json: { error: I18n.t('Unauthorized - post_delete_error') }, status: :forbidden
    end
  end

  # GET /posts/latest?page=n
  def latest
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
    render json: PostSerializer.new(@posts).serialized_json
  end

  
  private

    def post_params
      params.require(:post).permit(:body, :url, :topic_id).merge(user_id: current_user.id)
    end
end
