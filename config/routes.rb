Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root to: 'items#index'

  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do 
    resources :purchases, only: [:index, :create]
  end
  resources :cards, only: [:new, :create]
end

