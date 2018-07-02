class BaseController < ApplicationController
  include Pundit
  protect_from_forgery

  def pundit_user
    Services::Authorization::AccountContext.new(current_user, params[:user_id])
  end
end
