# frozen_string_literal: true

module Services
  class OlimpiaBank
    def initialize(options = {})
      @amount = options.fetch(:amount).to_i
      @account_id = options.fetch(:account_id)
    end

    CHECK_AMOUNT = 'ERROR: Please enter positive amount'
    NOT_ENOUGH_MONEY = 'ERROR: There is not enough money at the moment in account'

    private

    attr_reader :account_id, :amount

    def common_operation_errors(amount)
      raise OperationErrors::ZeroAmount, CHECK_AMOUNT if amount.zero?
      raise OperationErrors::NegativeAmount, CHECK_AMOUNT if amount.negative?
    end

    def withdraw_operation_errors(amount)
      raise OperationErrors::NotEnoughMoney, NOT_ENOUGH_MONEY if amount > target_account.balance
    end

    def target_account
      Account.find(account_id)
    end
  end
end
