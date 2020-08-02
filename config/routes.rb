Rails.application.routes.draw do
  namespace :admin do
      resources :admin_users
      resources :clients
      resources :invoices
      resources :sellers
      # resources :payments

      root to: "invoices#index"
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admin_users

  root to: "admin/admin_users#index"

  # devise_scope :admin_users do
  #   get 'sign_in',  to: 'devise/sessions#new'
  #   get 'sign_out', to: 'devise/sessions#destroy'
  # end
end
