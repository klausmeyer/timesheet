Rails.application.routes.draw do
  root to: "dashboard#show"

  devise_for :users

  resources :entries, only: [:index, :new, :create, :edit, :update, :destroy]

  scope "years/:year", constraints: {year: /\d+/} do
    resources :weeks, only: [:edit, :update], param: :week, constraints: {week: /\d+/}
  end
end
