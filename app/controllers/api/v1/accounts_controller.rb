module Api::V1
  class AccountsController < BaseController
  
    def index
      render json: accounts
    end

    def show
      render json: account
    end

    private

    def account
      @user ||= Account.find(params[:id])
    end

    def accounts
      @users ||= Account.all
    end
  end
end
