Rails.application.routes.draw do
  namespace :users do
    get 'omniauth_callbacks/facebook'
  end
  devise_for :users#, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'lots#index'
  resources :lots
  resources :tags
  resources :users
  resources :session_lots
end
