class PostSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :user

  attributes :title, :body, :url, :user_id, :topic_id, :created_at

  attribute :user_username do |object|
    User.find(object.user_id).username
  end
end
