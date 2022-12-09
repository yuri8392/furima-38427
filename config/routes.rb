Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'cards', to: 'users/registrations#new_card'
    post 'cards', to: 'users/registrations#pay'
    get 'cards', to: 'users/registrations#edit_card'
  end
  root to: 'items#index'

  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do 
    resources :purchases, only: [:index, :new, :create]
  end
  resources :cards, only: [:new, :create, :show, :destroy]
end
