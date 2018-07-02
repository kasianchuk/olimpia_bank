# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::WithdrawalsController, type: :request do
  let(:account) { create(:account) }
  let(:user) { create(:user, accounts: [account]) }

  SUCCESS_OPERATION = 'You make withdrawal'
  ERROR_NOT_ENOUGH_MONEY = 'ERROR: There is not enough money at the moment in account'

  describe 'Create' do
    context 'success response valid data' do
      it 'response status' do
        post "/api/v1/accounts/#{account.id}/withdrawals",
             headers: { 'Authorization': "Bearer #{user.token}" },
             params: { calculation: { amount: 1_000, account_id: account.id } }
        json_body = JSON.parse(response.body)
        expect(response.status).to eq(201)
        expect(json_body['message']).to eq(SUCCESS_OPERATION)
      end
    end

    context 'not success response' do
      it 'enter negative amount' do
        expect do
          post "/api/v1/accounts/#{account.id}/withdrawals",
               headers: { 'Authorization': "Bearer #{user.token}" },
               params: { calculation: { amount: -1_000, account_id: account.id } }
        end.to raise_error(RuntimeError, ERROR_NOT_POSITIVE_AMOUNT)
      end

      it 'enter String amount' do
        expect do
          post "/api/v1/accounts/#{account.id}/withdrawals",
               headers: { 'Authorization': "Bearer #{user.token}" },
               params: { calculation: { amount: VALUE, account_id: account.id } }
        end.to raise_error(RuntimeError, ERROR_NOT_POSITIVE_AMOUNT)
      end

      it 'enter amount more than Account balance' do
        expect do
          post "/api/v1/accounts/#{account.id}/withdrawals",
               headers: { 'Authorization': "Bearer #{user.token}" },
               params: { calculation: { amount: 10_000, account_id: account.id } }
        end.to raise_error(RuntimeError, ERROR_NOT_ENOUGH_MONEY)
      end
    end
  end
end
