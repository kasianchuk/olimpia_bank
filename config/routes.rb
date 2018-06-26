Rails.application.routes.draw do
  root to: 'profile#dashboard'
  get 'profile/dashboard'
  get 'profile/transactions'

  devise_for :users

  resources :accounts
  resources :deposits

  resources :users do
    resources :accounts do
      get 'deposit', on: :member
      get 'withdraw', on: :member
      collection do
        post 'deposit_operation', as: :deposit_operation
        post 'withdraw_operation', as: :withdraw_operation
      end
    end
  end
end
