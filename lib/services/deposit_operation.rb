# frozen_string_literal: true

module Services
  class DepositOperation < Services::OlimpiaBank
    DEPOSIT = 'deposit'

    def calculate
      target_account.update_columns(balance: target_account.balance + amount)
      MoneyOperation.create!(amount: amount, operation: DEPOSIT,
                             account_id: target_account.id)
    end
  end
end
