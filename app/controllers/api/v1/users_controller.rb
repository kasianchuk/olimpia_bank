module Api::V1
  class UsersController < BaseController

    def show
      render json: user, each_serializer: UserSerializer
    end

    def update
      if user.update(user_params)
        render json: user, each_serializer: UserSerializer
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
  end
end
