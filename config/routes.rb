Rails.application.routes.draw do
  root to: 'requests#new'
  resources :requests, only: [:new, :create, :show]
end
