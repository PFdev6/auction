Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'callbacks' }
  root 'lots#index'
  resources :main_news
  resources :lots
  resources :messages, only: %i[destroy update]
  resources :tags, only: %i[show destroy]
  resources :users do
    get 'win_lots'
    get 'user_bids'
    post 'sort_by_date'
  end
  authenticated :user, -> user { user.isadmin? } do
    mount Delayed::Web::Engine, at: '/jobs'
  end
  mount Ckeditor::Engine => '/ckeditor'
  resources :current_bargains, only: %i[show index destroy edit] do 
    resources :comments
    patch '/' => 'current_bargains#update'
  end
  get '/search' => 'home#search'

  mount ActionCable.server => '/cable'
end
