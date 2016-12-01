class HomeController < ApplicationController
  def index
  end

  def search
    render json: Song.title_for(params[:term])
  end
end