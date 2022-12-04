Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'cards', to: 'users/registrations#new_card'
    post 'cards', to: 'users/registrations#pay'
  end
  root to: 'items#index'

  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do 
    resources :purchases, only: [:index, :create]
  end
  resources :cards, only: [:new, :create, :show, :destroy]
end

