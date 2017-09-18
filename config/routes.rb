Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  root to: 'pages#home'
  resources :games, only: [:new, :create, :show] do

  end

  namespace :games do
    post ':game_id/attempts', to: 'attempts#create', as: 'attempts'  
  end

  resources :leaderboard, only: :index

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
