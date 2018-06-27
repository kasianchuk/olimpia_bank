# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AccountsController, type: :request do
  let(:account) { create(:account) }
  let(:user) { create(:user) }

  UNAUTHORIZED = 'Unauthorized'

  describe 'Index' do
    context 'not valid user token' do
      it 'response status' do
        get "/api/v1/users/#{user.id}/accounts", headers: { 'Authorization':
          'Bearer wrong_password' }
        expect(response.status).to eq(401)
      end

      it 'response message' do
        get "/api/v1/users/#{user.id}/accounts", headers: { 'Authorization':
          'Bearer wrong_password' }
        expect(response.message).to eq(UNAUTHORIZED)
      end
    end

    it 'response status' do
      get "/api/v1/users/#{user.id}/accounts", headers: { 'Authorization':
        "Bearer #{user.token}" }
      json_body = JSON.parse(response.body)
      expect(json_body.count).to eq(0)
    end
  end

  describe 'Show' do
    context 'not valid user token' do
      it 'response status' do
        get "/api/v1/users/#{user.id}/accounts/#{account.id}", headers: { 'Authorization':
          'Bearer wrong_password' }
        expect(response.status).to eq(401)
      end

      it 'response message' do
        get "/api/v1/users/#{user.id}/accounts/#{account.id}", headers: { 'Authorization':
          'Bearer wrong_password' }
        expect(response.message).to eq(UNAUTHORIZED)
      end

      it 'response status' do
        get "/api/v1/users/#{user.id}/accounts/#{account.id}", headers: { 'Authorization':
          "Bearer #{user.token}" }
        json_body = JSON.parse(response.body)
        expect(json_body.count).to eq(0)
      end
    end
  end
end
