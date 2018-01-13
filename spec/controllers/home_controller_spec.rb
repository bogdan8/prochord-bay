require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'Get #search' do
    it 'with location and without term' do
      get :search, params: { locale: :en }
      expect(response.status).to eq(400)
    end

    it 'with location and with term' do
      get :search, params: { locale: :en, term: :some_title }
      expect(response.status).to eq(200)
    end
  end
end
