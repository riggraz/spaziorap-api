class LikeSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :post
  belongs_to :user

  attributes :score, :post_id, :user_id, :updated_at
end
