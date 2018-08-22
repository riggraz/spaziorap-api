class SongsController < ApplicationController
  # GET /songs (returns latest songs)
  def index
    @songs = Song.order(created_at: :desc).limit(25)
    render json: SongSerializer.new(@songs).serialized_json
  end
end
