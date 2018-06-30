module Api::V1
  class BaseController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    before_action :authenticate

    private

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _|
        User.find_by(token: token, id: user.id)
      end
    end

    def render_unauthorized
      render json: {
        error_message: 'Bad credentials'
      }, status: :unauthorized
    end

    def not_found
      render json: {
        error_message: 'Not found'
      }, status: :not_found
    end
  end
end
