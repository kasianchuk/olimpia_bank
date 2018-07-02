module Services
  module Mailers
    class SendEmail
      def initialize(options = {})
        @balance = options.fetch(:balance)
        @operation = options.fetch(:operation)
        @user = options.fetch(:user)
        @amount = options.fetch(:amount)
      end

      def call
        Services::Mailers::UserMailer.with(balance: balance,
                                           operation: operation,
                                           user: user).money_operation.deliver_now
        admin_email if amount > 5000
      end

      private

      def admin_email
        Services::Mailers::AdminMailer.with(balance: balance,
                                            operation: operation,
                                            user: user).money_operation.deliver_now
      end

      attr_reader :balance, :operation, :user, :amount
    end
  end
end
