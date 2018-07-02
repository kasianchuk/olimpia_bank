class UsersController < BaseController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def show
    authorize set_user
  end

  def edit
    authorize set_user
  end

  def update
    authorize set_user
    if set_user.update(user_params)
      redirect_to set_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
