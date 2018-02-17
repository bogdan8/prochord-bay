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
        expect(response).to redirect_to(song_path(Song.last.slug))
      end
    end

    context 'if error' do
      login_user
      it 'renders the new template' do
        post :create, params: { song: { title: :test }, locale: :en }
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
    context 'redirect' do
      login_user
      it 'to song page' do
        body = 'new text in body'
        post :update, params: { id: song.slug, locale: :en, song: { body: body } }
        expect(Song.find_by(slug: song.slug).body).to eq(body)
        expect(response).to redirect_to(song_path(song.slug))
      end
    end
  end

  describe 'GET #destroy' do
    context 'if admin' do
      login_admin
      it 'the number of songs should decrease' do
        song.save
        songs = Song.count
        get :destroy, params: { id: song.slug, locale: :en }
        expect(Song.count).to eq(songs - 1)
      end
      it 'redirect to songs page' do
        song.save
        get :destroy, params: { id: song.slug, locale: :en }
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
    context 'redirect' do
      login_user
      it 'to song page' do
        get :like, params: { id: song.slug, user_id: user.id, song_id: song.id, locale: :en }
        expect(response).to redirect_to(song_path(Song.last.slug))
      end
    end
  end

  describe 'GET #do_active' do
    context 'set active' do
      login_admin
      it 'redirect and change active' do
        song.active = 0
        song.save
        get :do_active, params: { id: song.slug, locale: :en }
        expect(Song.last.active).to eq(1)
        expect(response).to redirect_to(not_active_songs_path)
      end
    end
  end

  describe 'GET #not_active' do
    context 'renders' do
      login_admin
      it 'the not_active template' do
        get :not_active, params: { id: song.slug, locale: :en }
        expect(response).to render_template('not_active')
      end
    end
  end
end
