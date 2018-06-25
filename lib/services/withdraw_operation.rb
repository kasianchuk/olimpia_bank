module Services
  class WithdrawOperation < Services::OlimpiaBank
    def calculate
      target_account.update_columns(balance: target_account.balance - amount)
      Withdraw.create!(amount: amount, account_id: target_account.id)
    end
  end
end
