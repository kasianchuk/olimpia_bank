class ProfileController < ApplicationController
  before_action :authenticate_user!

  layout 'profile'

  def dashboard
    accounts
  end

  def transactions
    deposit_transaction
    withdraw_transaction
  end

  private

  def accounts
    @accounts = current_user.accounts
  end

  def deposit_transaction
    @deposits = MoneyOperation.where(account_id: accounts.ids,
                                     operation: 'deposit').includes(:account)
    @deposits = @deposits.by_deposit(params[:deposit_id]) if params[:deposit_id].present?
  end

  def withdraw_transaction
    @withdraws = MoneyOperation.where(account_id: accounts.ids,
                                      operation: 'withdraw').includes(:account)
    @withdraws = @withdraws.by_withdraw(params[:withdraw_id]) if params[:withdraw_id].present?
  end
end
