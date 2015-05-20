Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
      member do
        patch :approve
        patch :deny
      end
  end
  # resources :cat_rental_requests, only: [:destroy, :edit, :update, :show]
end
