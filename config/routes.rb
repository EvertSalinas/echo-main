Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "admin/dashboard#index"

  get  '/invoices',  to: 'invoices#index'
  get  '/payment_log',  to: 'payment_logs#show'

  # devise_scope :admin_users do
  #   get 'sign_in',  to: 'devise/sessions#new'
  #   get 'sign_out', to: 'devise/sessions#destroy'
  # end
end
