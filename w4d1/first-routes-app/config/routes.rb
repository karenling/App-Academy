Rails.application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    get 'favorites', on: :member
    resources :contacts, only: [:index]
    resources :comments, only: [:index]
  end

  resources :contacts, only: [:create, :destroy, :show, :update] do
    resources :comments, only: [:index]
  end

  resources :contact_shares, only: [:create, :destroy]
end
