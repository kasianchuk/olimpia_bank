require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user) }
  let(:bad_user) { create(:bad_user) }

  describe 'Index' do
    it 'unvalid user token' do
      get '/api/v1/users', headers: { 'Authorization': 'Bearer wrong_password' }
      expect(response.status).to eq(401)
    end

    it 'get correct json responce' do
      get '/api/v1/users', headers: { 'Authorization': "Bearer #{user.token}" }
      expect(response.content_type).to eq('application/json')
      json_body = JSON.parse(response.body)
      expect(json_body.count).to eq(1)
      expect(json_body[0]['name']).to eq(user.name)
      expect(json_body[0]['id']).to eq(user.id)
    end
  end
end
