class ProfileController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @accounts = current_user.accounts
  end
end
