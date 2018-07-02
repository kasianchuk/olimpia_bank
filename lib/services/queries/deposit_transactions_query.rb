# frozen_string_literal: true

module Services
  module Queries
    class DepositTransactionsQuery
      attr_reader :relation

      OPERATION = 'deposit'

      def initialize(relation = MoneyOperation.all)
        @relation = relation
      end

      def call(account_ids)
        relation
          .where(account_id: account_ids)
          .where(operation: OPERATION)
          .includes(:account)
      end

      def by_id(account_ids, deposit_id)
        relation
          .where(account_id: account_ids)
          .where(operation: OPERATION)
          .where(id: deposit_id)
          .includes(:account)
      end
    end
  end
end
