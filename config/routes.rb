Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
  }

  resources :users, only: [:edit, :update, :destroy]

  namespace :blog do
    resources :users, only: [:show]
  end

  root to: 'blog/users#show'
end
