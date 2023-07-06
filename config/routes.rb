Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  unauthenticated do
    root 'users#index', as: :unauthenticated_root
  end

  resources :users, only: [:index]

  resources :categories do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end
  
end
