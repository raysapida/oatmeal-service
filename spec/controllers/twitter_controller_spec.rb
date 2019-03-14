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

      p json['tweets']
      expect(response).to be_successful
      expect(json['status']).to eq 'ok'
      expect(json['tweets'].size).to eq 10
    end
  end
end
