class UsersController < BaseController
  before_action :authenticate_user!
  before_action :user, only: %i[show edit update]

  def show
    authorize user
  end

  def edit
    authorize user
  end

  def update
    authorize user
    if user.update(user_params)
      redirect_to user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
