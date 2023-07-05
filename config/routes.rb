Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  resources :users, only: [:index]

  resources :categories do
    resources :items, only: [:show, :new, :create, :edit, :update, :destroy]
  end
  
end
