module Services
  class OlimpiaBank
    def initialize(options = {})
      @ammount = options.fetch(:amount).to_i
      @operation = options.fetch(:operation)
      @account_id = options.fetch(:account_id)
    end

    def calculate
      account = Account.find(account_id)
      account.update_columns(balance: account.balance + ammount) if deposite?
      account.update_columns(balance: account.balance - ammount) if withdraw?
    end

    private

    attr_reader :operation, :account_id, :ammount

    def deposite?
      operation == 'deposite'
    end

    def withdraw?
      operation == 'withdraw'
    end
  end
end
