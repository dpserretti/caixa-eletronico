Rails.application.routes.draw do
  resources :accounts
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get 'deposit' => 'transfers#deposit'
  post 'deposit' => 'transfers#depositar'

  get 'withdraw' => 'transfers#withdraw'
  post 'withdraw' => 'transfers#sacar'

  get 'transfer' => 'transfers#transfer'
  post 'transfer' => 'transfers#transferir'

  get 'extract' => 'transfers#extract'
  post 'extract' => 'transfers#extrato'

  get 'balance' => 'transfers#balance'
  post 'balance' => 'transfers#saldo'
end
