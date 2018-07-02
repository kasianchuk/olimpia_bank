module Services
  module Modules
    # The DepositErrorsCheck module is responsible for check errors before deposit

    module DepositErrorsCheck
      def common_operation_errors(amount)
        raise Services::OperationErrors::ZeroAmount.call if amount.zero?
        raise Services::OperationErrors::NegativeAmount.call if amount.negative?
      end
    end
  end
end
