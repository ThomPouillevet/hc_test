Rails.application.routes.draw do
  root to: 'requests#new'
  resources :requests, only: [:new, :create, :show]
   get '/:token/confirm_email/', :to => "requests#confirm_email", as: 'confirm_email'
end
