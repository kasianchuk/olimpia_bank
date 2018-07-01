module Admin
  class AccountsController < Admin::BaseController
    before_action :authenticate_user!
    before_action :set_account, only: %i[show edit update destroy]

    def index
      @accounts = Account.all.includes(:user)
    end

    def show; end

    def new
      @account = Account.new
    end

    def edit; end

    def create
      if new_account.save
        redirect_to admin_accounts_path, notice: 'Account was successfully created.'
      else
        render :new
      end
    end

    def update
      if set_account.update(account_params)
        redirect_to admin_accounts_path, notice: 'Account was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      set_account.destroy
      redirect_to admin_accounts_path, notice: 'Account was successfully destroyed.'
    end

    private

    def set_account
      @account = Account.find(params[:id])
    end

    def new_account
      @account = Account.new(account_params)
    end

    def account_params
      params.require(:account).permit(:user_id, :balance, :currency)
    end
  end
end
