class WithdrawalsController < BaseController
  before_action :authenticate_user!
  before_action :account, only: %i[new create]

  layout 'profile'

  def new
    @balance = account.balance
    authorize account
  end

  def create
    authorize account
    Services::WithdrawOperation.new(calculation_params).calculate
    redirect_to root_path, notice: 'Account amount successfully update.'
  end

  private

  def account
    @account = Account.find(params[:account_id])
  end

  def calculation_params
    params.require(:calculation).permit(:amount, :account_id)
  end
end
