Rails.application.routes.draw do
  get 'welcome/index'

  resources :sinfest, only: :index

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
