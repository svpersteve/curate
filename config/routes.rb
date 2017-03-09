Rails.application.routes.draw do
  root to: 'pages#index'

  get   '/login', to: 'sessions#new', as: :login
  match '/auth/:provider/callback', via: [:get, :post], to: 'sessions#create'
  match '/auth/failure', via: [:get, :post], to: 'sessions#failure'
end
