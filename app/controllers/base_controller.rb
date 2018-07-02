class BaseController < ApplicationController
  include Pundit
  protect_from_forgery

  def pundit_user
    Services::Authorization::AccountContext.new(pundit_params)
  end

  private

  def pundit_params
    { current_user: current_user,
      params_user_id: params[:user_id] }
  end
end
