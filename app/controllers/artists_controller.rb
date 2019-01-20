class ArtistsController < ApplicationController
  # GET /artists (returns all artists)
  def index
    @artists = Artist.where(foreign: false)
    render json: ArtistSerializer.new(@artists).serialized_json
  end
end
