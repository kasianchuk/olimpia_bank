# frozen_string_literal: true

module Services
  module Queries
    class WithdrawTransactionsQuery
      attr_reader :relation

      OPERATION = 'withdraw'

      def initialize(relation = MoneyOperation.all)
        @relation = relation
      end

      def call(account_ids)
        relation
          .where(account_id: account_ids, operation: OPERATION)
          .includes(:account)
      end

      def by_id(account_ids, withdraw_id)
        relation
          .where(account_id: account_ids)
          .where(operation: OPERATION)
          .where(id: withdraw_id)
          .includes(:account)
      end
    end
  end
end
