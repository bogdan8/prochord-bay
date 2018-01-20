require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  let(:user) { create(:user) }
  let(:performer) { create(:performer) }
  let(:song) { create(:song, user_id: user.id, performer_id: performer.id) }
  describe 'GET #index' do
    it 'renders the index template' do
      get :index, params: { locale: :en }
      expect(response).to render_template('index')
    end

    it 'has a 200 status code' do
      get :index, params: { locale: :en }
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context 'if success' do
      login_user
      it 'the number of songs should increase' do
        songs = Song.count
        post :create, params: { song: build(:song).attributes, locale: :en }
        expect(Song.count).to eq(songs + 1)
      end

      it 'redirect to song page' do
        post :create, params: { song: build(:song).attributes, locale: :en }
        expect(response).to redirect_to(song_path(Song.last.id))
      end
    end

    context 'if error' do
      login_user
      it 'renders the new template' do
        post :create, params: { song: { title: 'test' }, locale: :en }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'renders the show template with song' do
      get :show, params: { id: song.slug, locale: :en }
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    context 'renders the edit template with song' do
      login_user
      it 'user sign in' do
        get :edit, params: { id: song.slug, locale: :en }
        expect(response.status).to eq(200)
        expect(response).to render_template('edit')
      end
    end
    context 'renders the edit template with song' do
      it 'without user sign in' do
        get :edit, params: { id: song.slug, locale: :en }
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'POST #update' do
    login_user
    it 'redirect to song page' do
      post :update, params: { id: song.slug, locale: :en, song: { body: 'new text in body' } }
      expect(response).to redirect_to(song_path(Song.last.slug))
    end
  end

  describe 'GET #destroy' do
    context 'if admin' do
      login_admin
      it 'redirect to songs page' do
        song.save
        songs = Song.count
        get :destroy, params: { id: song.slug, locale: :en }
        expect(Song.count).to eq(songs - 1)
        expect(response).to redirect_to(songs_path)
      end
    end
    context 'if user' do
      login_user
      it 'redirect to root page' do
        get :destroy, params: { id: song.slug, locale: :en }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #like' do
    login_user
    it 'redirect to song page' do
      get :like, params: { id: song.slug, user_id: user.id, song_id: song.id, locale: :en }
      expect(response).to redirect_to(song_path(Song.last.slug))
    end
  end

  describe 'GET #do_active' do
    login_admin
    it 'set active' do
      song.active = 0
      song.save
      get :do_active, params: { id: song.slug, locale: :en }
      expect(Song.last.active).to eq(1)
      expect(response).to redirect_to(not_active_songs_path)
    end
  end

  describe 'GET #not_active' do
    login_admin
    it 'renders the not_active template' do
      get :not_active, params: { id: song.slug, locale: :en }
      expect(response).to render_template('not_active')
    end
  end
end
