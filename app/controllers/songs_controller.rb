class SongsController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    search = Song.search(include: :performer) do
      with :active, 1
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 30
    end
    @songs = search.results
  end

  def show
    @song.update_attributes(count_views: @song.count_views + 1)
  end

  def new; end

  def create
    @song = Song.new(song_params)
    if verify_recaptcha(model: @song) && @song.save
      UserMailer.send_add_song(@song.user, @song).deliver_now!
      redirect_to @song, success: t('controllers.songs.success_create')
    else
      flash[:error] = @song.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if verify_recaptcha(model: @song) && @song.update(song_params)
      redirect_to @song, success: t('controllers.songs.success_update')
    else
      flash[:error] = @song.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @song.destroy
      redirect_to songs_path, success: t('controllers.songs.success_delete')
    else
      flash[:error] = @song.errors.full_messages.to_sentence
    end
  end

  def like
    if Like.find_by(user_id: current_user.id, song_id: @song.id)
      redirect_to song_path(@song), error: t('controllers.songs.like_error')
    else
      Like.create(user_id: current_user.id, song_id: @song.id)
      redirect_to song_path(@song), success: t('controllers.songs.like_success')
    end
  end

  def search
    search = Song.search(include: :performer) do
      fulltext params[:title].downcase
      with :active, 1
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 30
    end
    @songs = search.results
  end

  def not_active
    search = Song.search(include: :performer) do
      with :active, 0
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 30
    end
    @songs = search.results
  end

  def do_active
    @song.update(active: 1)
    UserMailer.send_add_song_active(@song.user, @song).deliver_now!
    redirect_to not_active_songs_path, success: t('controllers.songs.active')
  end

  private

  def song_params
    params.require(:song).permit(:performer_id, :title, :body, :likes_count, :slug).merge(user_id: current_user.id)
  end
end
