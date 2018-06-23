Rails.application.routes.draw do
  root to: 'profile#dashboard'
  get 'profile/dashboard'
  devise_for :users

  resources :accounts

  resources :users do
    resources :accounts do
      get 'deposit', on: :member
      get 'withdraw', on: :member
      collection do
        post 'operation', as: :operation
      end
    end
  end
end
