# frozen_string_literal: true

module Services
  class WithdrawOperation < Services::OlimpiaBank
    WITHDRAW = 'withdraw'
    def calculate
      target_account.update_columns(balance: target_account.balance - amount)
      MoneyOperation.create!(amount: amount, operation: WITHDRAW,
                             account_id: target_account.id)
    end
  end
end
