class TopicsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

  # GET /topics
  def index
    @topics = Topic.order(name: :asc)
    render json: TopicSerializer.new(@topics).serialized_json
  end

end
