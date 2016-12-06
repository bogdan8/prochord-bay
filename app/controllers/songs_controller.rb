class SongsController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    search = Song.search do
      with :active, 1
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 30
    end
    @songs = search.results
  end

  def show
    @song.count_views += 1
    @song.save
  end

  def new
  end

  def create
    @song = Song.new(song_params)
    if verify_recaptcha(model: @song) && @song.save
      redirect_to @song, flash: { success: 'Успішно додано' }
    else
      flash[:error] = @song.errors.full_messages.to_sentence
      render :new
    end
    @song.save
  end

  def edit
  end

  def update
    if @song.update song_params
      redirect_to @song, flash: { success: 'Відредаговано' }
    else
      flash[:error] = @song.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @song.destroy
      redirect_to songs_path, flash: { success: 'Видалено' }
    else
      flash[:error] = @song.errors.full_messages.to_sentence
    end
  end

  def like
    if Like.find_by(user_id: current_user.id, song_id: @song.id)
      redirect_to @song, flash: { error: 'Вам уже сподобалось' }
    else
      Like.create(user_id: current_user.id, song_id: @song.id)
      redirect_to @song, flash: { success: 'Вам сподобалось' }
    end
  end

  def search
    search = Song.search(include: :likes) do
      fulltext params[:title].downcase
      with :active, 1
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 30
    end
    @songs = search.results
  end

  private

  def song_params
    params.require(:song).permit(:performer, :title, :body, :likes_count, :slug)
  end
end
