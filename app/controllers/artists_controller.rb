class ArtistsController < ApplicationController
  # GET /artists (returns all artists)
  def index
    @artists = Artist.all

    render json: ArtistSerializer.new(@artists).serialized_json
  end
end
