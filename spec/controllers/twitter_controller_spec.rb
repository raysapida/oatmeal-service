require 'rails_helper'

RSpec.describe TwitterController, type: :controller do
  describe 'GET #index' do
    it 'returns an array of tweets' do
      get :index

      expect(response).to be_successful
    end
  end

  describe 'GET #search' do
    it 'returns an array of 10 tweets' do
      get :search, params: { format: :json, q: '#healthcare' }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json['status']).to eq 'ok'
      expect(json['tweets'].size).to eq 10
    end

    it 'should save tweets found into the database' do
      expect{
        get :search, params: { format: :json, q: '#healthcare' }
      }.to change(Tweet, :count).by(10)
    end
  end
end
