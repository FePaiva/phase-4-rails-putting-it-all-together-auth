Rails.application.routes.draw do
  resources :recipes, only: [:index, :create]
  resources :users

  post "/signup", to: "users#create"
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


end
