# frozen_string_literal: true

module Api
  module V1
    class AccountsController < BaseController
      DELETE_RECORD = 'record deleted'

      def index
        render json: accounts, each_serializer: AccountSerializer
      end

      def show
        render json: account, each_serializer: AccountSerializer
      end

      def create
        account = Account.new(account_params)

        if account.save
          render json: account, status: :created
        else
          render json: account.errors, status: :unprocessable_entity
        end
      end

      def destroy
        account.destroy
        render json: { message: DELETE_RECORD }, status: :ok
      end

      private

      def user
        @user ||= User.find(params[:user_id])
      end

      def account
        @account ||= user.accounts.find(params[:id])
      end

      def accounts
        @accounts ||= user.accounts.includes(:money_operations)
      end

      def account_params
        params.require(:account).permit(:user_id, :balance, :currency)
      end
    end
  end
end
