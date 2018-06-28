module Api::V1
  class UsersController < BaseController

    def index
      render json: users, each_serializer: UserSerializer
    end

    def show
      render json: user, each_serializer: UserSerializer
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def users
      @users ||= User.all
    end
  end
end
