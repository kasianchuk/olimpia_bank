# frozen_string_literal: true

module Services
  # The WithdrawOperation class is responsible for deposit money

  class WithdrawOperation < Services::OlimpiaBank
    include Services::Modules::WithdrawErrorsCheck

    WITHDRAW = 'withdraw'

    def calculate
      common_operation_errors(amount)
      target_account.update_columns(balance: target_account_balance - amount)
      MoneyOperation.create!(amount: amount, operation: WITHDRAW,
                             account_id: target_account_id)

      Services::Mailers::SendEmail.new(mail_params).call
    end

    private

    def mail_params
      { balance: target_account_balance,
        operation: WITHDRAW,
        user: target_account_user,
        amount: amount }
    end
  end
end
