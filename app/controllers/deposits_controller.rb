# frozen_string_literal: true

class DepositsController < BaseController
  before_action :authenticate_user!
  before_action :set_account, only: [:new]

  layout 'profile'

  def new
    @balance = set_account.balance
  end

  def create
    Services::DepositOperation.new(calculation_params).calculate
    redirect_to root_path, notice: 'Account amount successfully update.'
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def calculation_params
    params.require(:calculation).permit(:amount, :account_id)
  end
end
