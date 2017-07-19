Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  resources :users, only: [:edit, :update, :destroy] do
    # TODO: test member routes and controller
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get 'static_pages/index'

  namespace :blog do
    resources :users, only: [:show]
  end

  root to: 'static_pages#index'
end
