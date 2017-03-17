Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations", passwords: "passwords", sessions: "sessions" }
  root to: 'pages#index'

  resources :users, path: 'artists'
  get '/users', to: redirect('/artists')

  resources :posts do
    member do
      get :publishing, path: 'publish'
      post :publish
      get :unpublishing, path: 'unpublish'
      post :unpublish
    end
  end
end
