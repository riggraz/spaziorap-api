class PostSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :body, :url
end
