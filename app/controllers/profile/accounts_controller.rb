class Profile::AccountsController < ApplicationController
  before_action :set_account, only: [:deposite, :withdraw]

  def deposite
    @balance = @account.balance
  end

  def withdraw
    @balance = @account.balance
  end

  def operation
    Services::OlimpiaBank.new(calculation_params).calculate
    redirect_to root_path, notice: 'Account amount successfully update.'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def calculation_params
    params.require(:calculation).permit(:amount, :operation, :account_id)
  end
end
