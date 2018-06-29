# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :controller do
  before(:example) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    sign_in user
  end

  describe 'Detect screens' do
    it 'desktop layout' do
      get :index
      expect(response).to render_template(layout: :application)
    end

    it 'mobile layout' do
      get :index, params: { mobile: 1 }
      expect(response).to render_template(layout: 'application.mobile')
    end
  end
end
