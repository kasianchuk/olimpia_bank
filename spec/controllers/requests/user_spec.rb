# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  let(:account) { create(:account) }
  let(:user) { create(:user, accounts: [account]) }

  NAME = 'test'
  PASSWORD = 'new_pass'
  EMAIL = 'test@test.com'
  OK = 'OK'

  describe 'Show' do
    it 'unvalid user token' do
      get "/api/v1/users/#{user.id}", headers: { 'Authorization': 'Bearer wrong_password' }
      expect(response.status).to eq(401)
    end

    it 'get correct json responce' do
      get "/api/v1/users/#{user.id}", headers: { 'Authorization': "Bearer #{user.token}" }
      expect(response.content_type).to eq('application/json')
      json_body = JSON.parse(response.body)
      expect(json_body['name']).to eq(user.name)
      expect(json_body['id']).to eq(user.id)
      expect(json_body['accounts']).not_to be_empty
    end
  end

  describe 'Update' do
    it 'unvalid user token' do
      put "/api/v1/users/#{user.id}", headers: { 'Authorization': 'Bearer wrong_password' }
      expect(response.status).to eq(401)
    end

    it 'get correct json responce' do
      put "/api/v1/users/#{user.id}",
        headers: { 'Authorization': "Bearer #{user.token}" },
        params: { user: { name: NAME, password: PASSWORD, email: EMAIL } }
      expect(response.status).to eq(200)
      expect(response.message).to eq(OK)
    end
  end
end
