class ProfileController < BaseController
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
  end

  def withdraw_transaction
    @withdraws = MoneyOperation.where(account_id: accounts.ids,
                                      operation: 'withdraw').includes(:account)
  end
end
