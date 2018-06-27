module Services
  class WithdrawOperation < Services::OlimpiaBank
    def calculate
      target_account.update_columns(balance: target_account.balance - amount)
      MoneyOperation.create!(amount: amount, operation: operation,
                             account_id: target_account.id)
    end
  end
end
