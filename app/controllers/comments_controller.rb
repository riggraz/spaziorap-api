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
      create_notification(@comment)
      render json: CommentSerializer.new(@comment).serialized_json
    else
      render json: { error: I18n.t('comment_error') }, status: :unprocessable_entity
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id, post_id: params[:post_id])
    end

    def create_notification(comment)
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

        # sends push notification
        if User.find(receiver_id).push_notification_token.nil?
          return
        end

        client = Exponent::Push::Client.new
        sender_username = '<utente sconosciuto>'
        if User.find(sender_id)
          sender_username = User.find(sender_id).username
        end

        post_title = '<post sconosciuto>'
        if Post.find(params[:post_id])
          post_title = Post.find(params[:post_id]).body
        end

        messages = [{
          to: User.find(receiver_id).push_notification_token,
          sound: "default",
          title: "#{sender_username} ti ha risposto in '#{post_title}':",
          body: "#{comment.body}"
        }]
        client.publish messages
      end
    end

end
