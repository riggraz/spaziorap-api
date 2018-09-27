class CommentSerializer
  include FastJsonapi::ObjectSerializer

  attributes :body, :user_id, :post_id, :parent_id, :created_at

  attribute :user_username do |object|
    User.find(object.user_id).username
  end

  attribute :score do |object|
    score = 0
    likes = Like.where(comment_id: object.id)
    likes.each do |like|
      score += like.score
    end

    score
  end
end
