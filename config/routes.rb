Rails.application.routes.draw do
  root to: "dashboard#show"

  devise_for :users

  resources :entries, only: [:index, :new, :create, :destroy]
end
