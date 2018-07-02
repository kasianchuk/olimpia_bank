module Services
  module Mailers
    class UserMailer < ApplicationMailer
      default from: 'notifications@example.com'

      def money_operation
        user
        @balance = params[:balance]
        @operation = params[:operation]
        @url = 'http://olimpia_bank.com'
        mail(to: user.email, subject: 'Welcome to OlimpiaBank')
      end

      private

      def user
        @user = params[:user]
      end
    end
  end
end
