class SongsController < ApplicationController
  load_and_authorize_resource

  def index
    @songs = Song.order(:created_at).page(params[:page]).per(30)
  end

  def show
    @song = Song.find(params[:id])
    @song.count_views += 1
    @song.save
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if verify_recaptcha(model: @song) && @song.save
      redirect_to @song
      flash[:success] = 'Успішно додано'
    else
      flash[:error] = @song.errors.full_messages.to_sentence
      render :new
    end
    @song.save
    redirect_to @song
  end

  def edit

  end

  def like
    @song = Song.find(params[:id])
    if Like.find_by(user_id: current_user.id, song_id: @song.id)
      redirect_to @song
      flash[:error] = 'Вам уже сподобалось'
    else
      Like.create(user_id: current_user.id, song_id: @song.id)
      redirect_to @song
      flash[:success] = 'Вам сподобалось'
    end
  end

  private

  def song_params
    params.require(:song).permit(:performer, :title, :body)
  end

end