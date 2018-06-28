# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::DepositsController, type: :request do
  let(:account) { create(:account) }
  let(:user) { create(:user, accounts: [account]) }

  SUCCESS_DEPOSIT = 'You make deposit'

  describe 'Create' do
    context 'success response valid data' do
      it 'response status' do
        post "/api/v1/accounts/#{account.id}/deposits",
          headers: { 'Authorization': "Bearer #{user.token}" },
          params: { calculation: { amount: 1_000, account_id: account.id } }
        json_body = JSON.parse(response.body)
        expect(response.status).to eq(201)
        expect(json_body['message']).to eq(SUCCESS_DEPOSIT)
      end
    end

    context 'not success response' do
      it 'enter negative amount' do
        expect do
          post "/api/v1/accounts/#{account.id}/deposits",
            headers: { 'Authorization': "Bearer #{user.token}" },
            params: { calculation: { amount: -1_000, account_id: account.id } }
        end.to raise_error(Services::OperationErrors::NegativeAmount)
      end

      it 'enter String amount' do
        expect do
          post "/api/v1/accounts/#{account.id}/deposits",
            headers: { 'Authorization': "Bearer #{user.token}" },
            params: { calculation: { amount: VALUE, account_id: account.id } }
        end.to raise_error(Services::OperationErrors::ZeroAmount)
      end
    end
  end
end
