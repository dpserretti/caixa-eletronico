Rails.application.routes.draw do
  resources :accounts
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get 'deposit' => 'tranfers#deposit'
  post 'deposit' => 'tranfers#create'
end
