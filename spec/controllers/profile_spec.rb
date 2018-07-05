# frozen_string_literal: true

require 'rails_helper'

describe ProfileController, type: :controller do
  before(:example) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    sign_in user
  end

  describe 'Detect screens' do
    it 'desktop layout' do
      get :transactions
      expect(response).to render_template(layout: :profile)
    end

    it 'mobile layout' do
      get :transactions, params: { mobile: 1 }
      expect(response).to render_template(layout: 'profile.mobile')
    end
  end
end
