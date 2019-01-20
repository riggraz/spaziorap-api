class SongSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :name, :url, :artist_id

  attribute :artist_name do |object|
    Artist.find(object.artist_id).name
  end
  attribute :foreign do |object|
    Artist.find(object.artist_id).foreign
  end
end
