class TopicsController < ApplicationController
  # GET /topics
  def index
    @topics = Topic.order(name: :asc)
    render json: TopicSerializer.new(@topics).serialized_json
  end

end
