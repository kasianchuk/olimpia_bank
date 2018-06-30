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
    resources :deposits, only: %i[new create]
    resources :withdrawals, only: %i[new create]
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show update] do
        resources :accounts
      end

      resources :accounts, only: [] do
        resources :deposits, only: [:create]
        resources :withdrawals, only: [:create]
      end
    end
  end
end
