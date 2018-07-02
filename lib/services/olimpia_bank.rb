# frozen_string_literal: true

module Services
  # The OlimpiaBank class is basic class

  class OlimpiaBank
    def initialize(options = {})
      @amount = options.fetch(:amount).to_i
      @account_id = options.fetch(:account_id)
    end

    private

    attr_reader :account_id, :amount

    def target_account
      Account.find(account_id)
    end

    def target_account_balance
      target_account.balance
    end

    def target_account_id
      target_account.id
    end

    def target_account_user
      target_account.user
    end
  end
end
