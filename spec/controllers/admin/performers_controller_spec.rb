require 'rails_helper'

RSpec.describe Admin::PerformersController, type: :controller do
  let(:performer) { create(:performer) }
  describe 'GET #index' do
    context 'if admin' do
      login_admin
      it 'render the index template' do
        get :index, params: { locale: :en }
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
      end
    end
    context 'if user' do
      login_user
      it 'render status 302' do
        get :index, params: { locale: :en }
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'GET #show' do
    login_admin
    it 'render the show template' do
      get :show, params: { id: performer.slug, locale: :en }
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    login_admin
    it 'render the new template' do
      get :new, params: { locale: :en }
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    login_admin
    it 'the number of performers should increase' do
      performers = Performer.count
      post :create, params: { performer: build(:performer).attributes, locale: :en }
      expect(Performer.count).to eq(performers + 1)
    end

    it 'redirect to performer page' do
      post :create, params: { performer: build(:performer).attributes, locale: :en }
      expect(response).to redirect_to(performer_path(Performer.last.slug))
    end

    it 'render the new template if error' do
      post :create, params: { locale: :en, performer: { title: '' } }
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    login_admin
    it 'render the edit template' do
      get :edit, params: { id: performer.slug, locale: :en }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST #update' do
    login_admin
    it 'change title' do
      title = 'this new title'
      post :update, params: { id: performer.slug, locale: :en, performer: { title: title } }
      expect(Performer.last.title).to eq(title)
    end

    it 'redirect ot performer page' do
      post :update, params: { id: performer.slug, locale: :en, performer: { title: 'title' } }
      expect(response).to redirect_to(performer_path(performer.slug))
    end

    it 'render the new template if error' do
      post :update, params: { id: performer.slug, locale: :en, performer: { title: '' } }
      expect(response).to render_template('edit')
    end
  end

  describe 'GET #destroy' do
    login_admin
    it 'the number of performers should decrease' do
      performer.save
      performers = Performer.count
      delete :destroy, params: { id: performer.slug, locale: :en }
      expect(Performer.count).to eq(performers - 1)
    end

    it 'redirect to performers page' do
      performer.save
      delete :destroy, params: { id: performer.slug, locale: :en }
      expect(response).to redirect_to(performers_path)
    end
  end
end
