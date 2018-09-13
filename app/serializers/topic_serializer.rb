class TopicSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description
end
