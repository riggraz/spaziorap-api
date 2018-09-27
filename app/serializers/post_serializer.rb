class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :body, :url, :user_id, :topic_id, :created_at

  attribute :user_username do |object|
    User.find(object.user_id).username
  end

  attribute :score do |object|
    score = 0
    likes = Like.where(post_id: object.id)
    likes.each do |like|
      score += like.score
    end

    score
  end

  attribute :comments_count do |object|
    comments = Comment.where(post_id: object.id)
    comments_count = comments.size
  end
end
