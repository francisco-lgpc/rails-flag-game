Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :games, only: [:new, :create, :show]
  resources :questions, only: [] do
    resources :attempts, only: :create
  end

  resources :leaderboard, only: :index

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
