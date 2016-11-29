class SongsController < ApplicationController
  def index
    @songs = Song.page(1).per(30)
  end

  def show
    @song = Song.find(params[:id])
  end
end