class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :username, :admin, :access_token

  # attribute :score do |object|
  #   score = 0
  #   posts = Post.where(user_id: object.id)
  #   posts.each do |post|
  #     likes = Like.where(post_id: post.id)
  #     likes.each do |like|
  #       score += like.score
  #     end
  #   end

  #   score
  # end
end
