# frozen_string_literal: true

module Services
  class OperationErrors < Services::OlimpiaBank
    class NegativeAmount < StandardError; end
    class ZeroAmount < StandardError; end
    class NotEnoughMoney < StandardError; end
  end
end
