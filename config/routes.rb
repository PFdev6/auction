Rails.application.routes.draw do
  resources :main_news
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'lots#index'
  resources :lots
  resources :tags
  resources :users
  resources :current_bargains
end
