Rails.application.routes.draw do
  root to: 'profile#dashboard'
  devise_for :users

  namespace :profile do
    resources :accounts do
      get 'deposite', on: :member
      get 'withdraw', on: :member
      collection do
        post 'operation', as: :operation
      end
    end
  end

  resources :accounts
  resources :users
end
