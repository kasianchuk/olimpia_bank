# frozen_string_literal: true

module Services
  # The DepositOperation class is responsible for deposit money

  class DepositOperation < Services::OlimpiaBank
    DEPOSIT = 'deposit'

    def calculate
      common_operation_errors(amount)
      target_account.update_columns(balance: target_account.balance + amount)
      MoneyOperation.create!(amount: amount, operation: DEPOSIT,
                             account_id: target_account.id)
    end
  end
end
