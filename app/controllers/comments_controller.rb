class CommentsController < ApplicationController

  before_action :authenticate_user_from_token!, only: [:create]

  # GET /posts/:id/comments (comments of specified Post)
  def index
    @comments = Comment.where(post_id: params[:post_id]).order(created_at: :desc)
    render json: CommentSerializer.new(@comments).serialized_json
  end

  # POST /posts/:id/comments (create comment for specified Post)
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: CommentSerializer.new(@comment).serialized_json
    else
      render json: { error: I18n.t('comment_error') }, status: :unprocessable_entity
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id, post_id: params[:post_id])
    end

end
