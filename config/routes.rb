Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # namespace :admin do
  #     resources :admin_users
  #     resources :clients
  #     resources :invoices
  #     resources :sellers
  #     resources :payment_logs
  #     resources :payments
  #
  #     root to: "invoices#index"
  #   end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: "admin/admin_users#index"
  #
  get  '/invoices',  to: 'invoices#index'

  # devise_scope :admin_users do
  #   get 'sign_in',  to: 'devise/sessions#new'
  #   get 'sign_out', to: 'devise/sessions#destroy'
  # end
end
