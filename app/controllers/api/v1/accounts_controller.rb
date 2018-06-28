# frozen_string_literal: true

module Api::V1
  class AccountsController < BaseController
    DELETE_RECORD = 'record deleted'

    def index
      render json: accounts
    end

    def show
      render json: account
    end

    def create
      account = Account.new(account_params)

      if account.save
        render json: account, status: :created
      else
        render json: account.errors, status: :unprocessable_entity
      end
    end

    # def update
    #   if account.update(account_params)
    #     render json: account
    #   else
    #     render json: account.errors, status: :unprocessable_entity
    #   end
    # end

    def destroy
      account.destroy
      render json: { message: DELETE_RECORD }, status: :ok
    end

    private

    def account
      @account ||= Account.find(params[:id])
    end

    def accounts
      @accounts ||= Account.all
    end

    def account_params
      params.require(:account).permit(:user_id, :balance, :currency)
    end
  end
end
