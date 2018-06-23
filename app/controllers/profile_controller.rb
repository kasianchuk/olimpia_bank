class ProfileController < ApplicationController
  before_action :authenticate_user!

  layout 'profile'

  def dashboard
    @accounts = current_user.accounts
  end
end
