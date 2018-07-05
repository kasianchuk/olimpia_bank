class ApplicationController < ActionController::Base
  before_action :mobile_device?
  layout :desktop_or_mobile

  private

  def mobile_device?
    if params[:mobile].present?
      request.variant << :mobile
    else
      request.user_agent =~ /iPhone|Windows Phone|Android/
    end
  end

  helper_method :mobile_device?

  def desktop_or_mobile
    mobile_device? ? 'application.mobile' : 'application'
  end
end
