Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'callbacks' }
  root 'lots#index'
  resources :main_news
  resources :lots
  resources :messages, only:[:destroy]
  resources :tags, only:[:show, :destroy]
  resources :users do
    get "win_lots"
  end

  mount Ckeditor::Engine => '/ckeditor'
  ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :current_bargains, only: [:show, :index, :destroy, :edit] do 
    resources :comments
    patch '/' => 'current_bargains#update'
  end
 
  get '/search' => 'home#search'

  mount ActionCable.server => '/cable'
end
