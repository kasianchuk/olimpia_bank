# frozen_string_literal: true

module Services
  module OperationErrors
    CHECK_AMOUNT = 'ERROR: Please enter positive amount'
    NOT_ENOUGH_MONEY = 'ERROR: There is not enough money at the moment in account'

    # The NegativeAmount class check amount.negative?
    class NegativeAmount < StandardError
      def self.call
        CHECK_AMOUNT
      end
    end

    # The ZeroAmount class check amount.zero?
    class ZeroAmount < StandardError
      def self.call
        CHECK_AMOUNT
      end
    end

    # The NotEnoughMoney class check user.account.balance
    class NotEnoughMoney < StandardError
      def self.call
        NOT_ENOUGH_MONEY
      end
    end
  end
end
