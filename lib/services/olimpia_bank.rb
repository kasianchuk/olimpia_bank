module Services
  class OlimpiaBank
    def initialize(options = {})
      @amount = options.fetch(:amount).to_i
      @account_id = options.fetch(:account_id)
    end

    def target_account
      Account.find(account_id)
    end

    private

    attr_reader :operation, :account_id, :amount
  end
end
