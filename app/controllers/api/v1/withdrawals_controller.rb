# frozen_string_literal: true

module Api
  module V1
    class WithdrawalsController < BaseController
      OPERATION = 'You make withdrawal'

      def create
        Services::WithdrawOperation.new(calculation_params).calculate
        render json: { message: OPERATION }, status: :created
      end

      private

      def account
        @account ||= Account.find(params[:account_id])
      end

      def user
        @user ||= account.user
      end

      def calculation_params
        params.require(:calculation).permit(:amount, :account_id)
      end
    end
  end
end
