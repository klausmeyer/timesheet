Rails.application.routes.draw do
  root to: "dashboard#show"

  resources :entries, only: [:index, :new, :create]
end
