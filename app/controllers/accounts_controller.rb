class AccountsController < BaseController
  before_action :authenticate_user!
  before_action :account, only: %i[show edit update destroy]

  def index
    authorize index_accounts
  end

  def show
    authorize account
  end

  def new
    authorize new_account
  end

  def edit
    authorize account
  end

  def create
    authorize create_account
    if create_account.save
      redirect_to root_path, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize account
    if account.update(account_params)
      redirect_to root_path, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize account
    account.destroy
    redirect_to root_path, notice: 'Account was successfully destroyed.'
  end

  private

  def account
    @account = current_user.accounts.find(params[:id])
  end

  def new_account
    @account = Account.new
  end

  def create_account
    @account = Account.new(account_params)
  end

  def index_accounts
    @accounts = current_user.accounts
  end

  def account_params
    params.require(:account).permit(:user_id, :balance, :currency)
  end
end
