class SongsController < ApplicationController
  def index
    @songs = Song.order(:created_at).page(params[:page]).per(30)
  end

  def show
    @song = Song.find(params[:id])
    @song.count_views += 1
    @song.save
  end
end