class ArtistSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :foreign
end
