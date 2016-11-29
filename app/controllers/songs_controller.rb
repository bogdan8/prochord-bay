class SongsController < ApplicationController
  def index
    @songs = Song.page(params[:page]).per(30)
  end

  def show
    @song = Song.find(params[:id])
  end
end