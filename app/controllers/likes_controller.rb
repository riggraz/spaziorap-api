class LikesController < ApplicationController

  before_action :authenticate_user_from_token!, only: [:create]
  before_action :check_score, only: [:create]

  # POST /posts/:id/likes (create or update Like of specified Post by specified User)
  # POST /comments/:id/likes (create or update Like of specified Comment by specified User)
  def create
    @like = nil

    if params[:post_id]
      @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
      @like = @like || Like.new(post_id: params[:post_id], user_id: current_user.id)
    elsif params[:comment_id]
      @like = Like.find_by(comment_id: params[:comment_id], user_id: current_user.id)
      @like = @like || Like.new(comment_id: params[:comment_id], user_id: current_user.id)
    end
    
    # If User unliked or undisliked set score to 0, otherwise set it to like(1) or dislike(-1)
    score = params[:score].to_i
    @like.score == score ? @like.score = 0 : @like.score = score

    if @like.save
      render json: LikeSerializer.new(@like).serialized_json
    else
      render json: { error: I18n.t('Unauthorized - like_create_error') }, status: :forbidden
    end
  end

  private

    # check if score is -1 or 1. If not an error is thrown
    def check_score
      render json: { error: I18n.t('score_error') }, status: :unprocessable_entity unless params[:score].to_i == -1 or params[:score].to_i == 1
    end

end
