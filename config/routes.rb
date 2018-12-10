Rails.application.routes.draw do
  resources :main_news
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'lots#index'
  resources :lots
  resources :tags, only:[:show, :destroy]
  resources :users
  resources :current_bargains, only: [:show, :index, :destroy] do 
    resources :comments
  end
  resources :main_news
end
