class LikeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :score, :post_id, :comment_id, :user_id, :updated_at
end
