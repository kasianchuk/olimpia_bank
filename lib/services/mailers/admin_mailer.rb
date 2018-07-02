module Services
  module Mailers
    class AdminMailer < ApplicationMailer
      default from: 'notifications@example.com'

      def money_operation
        user
        @balance = params[:balance]
        @operation = params[:operation]
        @url = 'http://olimpia_bank.com'
        mail(to: ENV['EMAIL_ADDRESS'], subject: 'Admin mail OlimpiaBank')
      end

      private

      def user
        @user = params[:user]
      end
    end
  end
end
