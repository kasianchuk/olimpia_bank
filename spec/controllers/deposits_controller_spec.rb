require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  it "GET new" do
    get :new, params: {account_id: 1}
    expect(response.status).to eq(200)
  end
end
