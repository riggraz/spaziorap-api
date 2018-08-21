class LikesController < ApplicationController

  before_action :authenticate_user_from_token!, only: [:create]
  before_action :check_score, only: [:create]

  # GET /posts/:id/likes (Score of specified Post, based on Likes)
  def index
    @likes = Like.where(post_id: params[:post_id])
    post_score = 0
    @likes.each do |like|
      post_score += like.score
    end

    render json: post_score
  end

  # POST /posts/:id/likes (create or update Like of specified Post by specified User)
  def create
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like = @like || Like.new(post_id: params[:post_id], user_id: current_user.id)
    
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
