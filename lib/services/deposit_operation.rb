# frozen_string_literal: true

module Services
  # The DepositOperation class is responsible for deposit money

  class DepositOperation < Services::OlimpiaBank
    include Services::Modules::DepositErrorsCheck

    DEPOSIT = 'deposit'

    def calculate
      common_operation_errors(amount)
      target_account.update_columns(balance: target_account_balance + amount)
      MoneyOperation.create!(amount: amount, operation: DEPOSIT,
                             account_id: target_account.id)

      Services::Mailers::SendEmail.new(mail_params).call
    end

    private

    def mail_params
      { balance: target_account_balance,
        operation: DEPOSIT,
        user: target_account_user,
        amount: amount }
    end
  end
end
