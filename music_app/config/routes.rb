Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show, :index] do
    member do
      patch 'make_admin'
    end
    collection do
      get 'activate'
    end
  end
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

  resources :notes, only: [:create, :destroy]
end
