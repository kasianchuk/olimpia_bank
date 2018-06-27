Rails.application.routes.draw do
  root to: 'profile#dashboard'
  get 'profile/transactions'

  devise_for :users

  namespace :admin do
    resources :accounts
    resources :users
  end

  resources :users do
    resources :accounts
  end

  resources :accounts, only: [:index] do
    resources :deposits, only: [:index, :new, :create]
    resources :withdrawals, only: [:index, :new, :create]
  end
end
