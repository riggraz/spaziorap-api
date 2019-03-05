class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :body, :url, :user_id, :topic_id, :created_at

  attribute :user_username do |object|
    User.find(object.user_id).username
  end

  attribute :score do |object|
    Like.where(post_id: object.id).sum(:score)
  end

  attribute :comments_count do |object|
    Comment.where(post_id: object.id).size
  end
end
