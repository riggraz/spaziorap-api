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
      create_notification
      render json: CommentSerializer.new(@comment).serialized_json
    else
      render json: { error: I18n.t('comment_error') }, status: :unprocessable_entity
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id, post_id: params[:post_id])
    end

    def create_notification
      sender_id = current_user.id
      receiver_id = nil
      if (params[:comment][:parent_id] == nil)
        receiver_id = Post.find(params[:post_id]).user_id
      else
        receiver_id = Comment.find(params[:comment][:parent_id]).user_id
      end

      if sender_id != receiver_id
        notification = Notification.create(
          sender_id: sender_id,
          receiver_id: receiver_id,
          post_id: params[:post_id]
        )
      end
    end

end
