Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games, only: [:new, :create, :show]
  resources :questions, only: [] do
    resources :attempts, only: :create
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
