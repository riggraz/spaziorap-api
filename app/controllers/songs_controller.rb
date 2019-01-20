class SongsController < ApplicationController
  # GET /songs/latest (returns latest songs)
  def latest
    @songs = Song.where(latest: true).order(created_at: :desc).limit(30)
    render json: SongSerializer.new(@songs).serialized_json
  end
end
