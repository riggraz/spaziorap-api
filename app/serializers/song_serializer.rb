class SongSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :artist

  attributes :name, :url

  attribute :artist_name do |object|
    Artist.find(object.artist_id).name
  end
end
