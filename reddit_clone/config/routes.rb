Rails.application.routes.draw do
  root 'subs#index'
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new] do
    end
    post 'upvote'
    post 'downvote'
  end
  resources :comments, only: [:show, :create] do
    post 'upvote'
    post 'downvote'
  end
end
