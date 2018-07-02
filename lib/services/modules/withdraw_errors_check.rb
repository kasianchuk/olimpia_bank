module Services
  module Modules
    # The WithdrawErrorsCheck module is responsible for check errors before withdrawal

    module WithdrawErrorsCheck
      def common_operation_errors(amount)
        raise Services::OperationErrors::ZeroAmount.call if amount.zero?
        raise Services::OperationErrors::NegativeAmount.call if amount.negative?
        raise Services::OperationErrors::NotEnoughMoney.call if amount > target_account.balance
      end
    end
  end
end
