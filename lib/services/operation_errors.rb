# frozen_string_literal: true

module Services
  class OperationErrors < Services::OlimpiaBank
    # The NegativeAmount class check amount.negative?
    class NegativeAmount < StandardError; end
    # The ZeroAmount class check amount.zero?
    class ZeroAmount < StandardError; end
    # The NotEnoughMoney class check user.account.balance
    class NotEnoughMoney < StandardError; end
  end
end
