Rails.application.routes.draw do
  resources :accounts
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get 'deposit' => 'accounts#deposit'
  post 'deposit/:id' => 'accounts#index'
end
