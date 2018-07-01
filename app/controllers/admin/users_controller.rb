module Admin
  class UsersController < Admin::BaseController
    before_action :authenticate_user!
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = User.all
    end

    def show; end

    def new
      @user = User.new
    end

    def edit; end

    def create
      if new_user.save
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def update
      if set_user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      set_user.destroy
      redirect_to admin_users_path, notice: 'User was successfully destroyed.'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def new_user
      @user = User.new(user_params)
    end

    def user_params
      params.require(:user).permit(:name, :password, :email)
    end
  end
end
