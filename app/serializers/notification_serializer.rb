class NotificationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :sender_id, :receiver_id, :post_id, :sender_username, :post_body, :read, :created_at

  attribute :sender_username do |object|
    User.find(object.sender_id).username
  end

  attribute :post_body do |object|
    Post.find(object.post_id).body
  end
end
