class ProfileController < BaseController
  before_action :authenticate_user!

  layout 'profile'

  def dashboard
    accounts_index
  end

  def transactions
    deposit_transaction
    find_deposit_by_id if deposit_params.present?

    withdraw_transaction
    find_withdraw_by_id if withdraw_params.present?
  end

  private

  def accounts_index
    @accounts = current_user.accounts
  end

  def accounts
    @accounts = current_user.accounts.ids
  end

  def deposit_transaction
    @deposits = Services::Queries::DepositTransactionsQuery.new.call(accounts)
  end

  def find_deposit_by_id
    @deposits =
      Services::Queries::DepositTransactionsQuery
      .new.by_id(accounts, deposit_params)
  end

  def withdraw_transaction
    @withdraws = Services::Queries::WithdrawTransactionsQuery.new.call(accounts)
  end

  def find_withdraw_by_id
    @withdraws =
      Services::Queries::WithdrawTransactionsQuery
      .new.by_id(accounts, withdraw_params)
  end

  def deposit_params
    params[:deposit_id]
  end

  def withdraw_params
    params[:withdraw_id]
  end
end
