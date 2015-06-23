Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:show]
end
