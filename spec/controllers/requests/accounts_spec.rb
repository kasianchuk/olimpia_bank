# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AccountsController, type: :request do
  let(:account) { create(:account) }
  let(:user) { create(:user, accounts: [account]) }

  UNAUTHORIZED = 'Unauthorized'
  UNPROCESSABLE_ENTITY = 'Unprocessable Entity'
  CREATED = 'Created'
  NOT_BLANK = "can't be blank"
  CURRENCY_UAH = 'UAH'
  CURRENCY_USD = 'USD'
  OK = 'OK'
  DELETE_RECORD = 'record deleted'
  NOT_FOUND = 'Not Found'

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

    context 'valid token' do
      it 'response status' do
        get "/api/v1/users/#{user.id}/accounts", headers: { 'Authorization':
          "Bearer #{user.token}" }
        json_body = JSON.parse(response.body)
        expect(json_body[0]['user_id']).to eq(user.id)
      end
    end
  end

  describe 'Show' do
    it 'not valid accound id' do
      get "/api/v1/users/#{user.id}/accounts/#{rand(10_000)}", headers: { 'Authorization':
        "Bearer #{user.token}" }
      expect(response.status).to eq(404)
      expect(response.message).to eq(NOT_FOUND)
    end

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
    end

    context 'valid token' do
      it 'response status' do
        create(:user, accounts: [account])
        get "/api/v1/users/#{user.id}/accounts/#{account.id}", headers: { 'Authorization':
          "Bearer #{user.token}" }
        json_body = JSON.parse(response.body)
        expect(json_body['user_id']).to eq(user.id)
      end
    end
  end

  describe 'Create' do
    context 'success response' do
      it 'response status' do
        post "/api/v1/users/#{user.id}/accounts",
             headers: { 'Authorization': "Bearer #{user.token}" },
             params: { account: { user_id: user.id, balance: 1000, currency: CURRENCY_UAH } }
        expect(response.status).to eq(201)
        expect(response.message).to eq(CREATED)
      end
    end

    context 'not success response' do
      it 'response status validate to balance' do
        post "/api/v1/users/#{user.id}/accounts", headers: { 'Authorization': "Bearer
          #{user.token}" }, params: { account: { user_id: user.id, currency: CURRENCY_UAH } }
        json_body = JSON.parse(response.body)
        expect(json_body['balance']).to contain_exactly(NOT_BLANK)
        expect(response.status).to eq(422)
        expect(response.message).to eq(UNPROCESSABLE_ENTITY)
      end
    end
  end

  describe 'Delete' do
    context 'success response' do
      it 'response status' do
        delete "/api/v1/users/#{user.id}/accounts/#{account.id}",
               headers: { 'Authorization': "Bearer #{user.token}" }
        json_body = JSON.parse(response.body)
        expect(json_body['message']).to eq(DELETE_RECORD)
        expect(response.status).to eq(200)
        expect(response.message).to eq(OK)
      end
    end

    context 'not success response' do
      it 'response status, delete not exist account ' do
        delete "/api/v1/users/#{user.id}/accounts/#{rand(10_000)}",
               headers: { 'Authorization': "Bearer #{user.token}" }
        expect(response.status).to eq(404)
        expect(response.message).to eq(NOT_FOUND)
      end
    end
  end
end
