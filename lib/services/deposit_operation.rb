module Services
  class DepositOperation < Services::OlimpiaBank
    def calculate
      target_account.update_columns(balance: target_account.balance + amount)
      Deposit.create!(amount: amount, account_id: target_account.id)
    end
  end
end
