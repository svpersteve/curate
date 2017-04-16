Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations", passwords: "passwords", sessions: "sessions" }
  root to: 'pages#index'
  get '/about', to: 'pages#about'
  get '/events', to: 'pages#events'

  get '/request-email', to: 'users#request_email', as: 'request_email'

  resources :users, path: 'artists' do
    member do
      get :follow
      post :follow
      get :unfollow
      post :unfollow
    end
  end

  get '/users', to: redirect('/artists')
  get '/feed', to: 'users#home', as: 'updates'

  resources :conversations do
    resources :messages
  end

  resources :posts, path: 'journal' do
    member do
      get :publishing, path: 'publish'
      post :publish
      get :unpublishing, path: 'unpublish'
      post :unpublish
      get :like
      post :like
      get :unlike
      post :unlike
    end
  end

  get "/artists/:id/user-activity" => 'users#activity', as: 'user_activity'
  get "/artists/:id/user-pages" => 'users#posts', as: 'user_posts'
  get "/artists/:id/user-artworks" => 'users#artworks', as: 'user_artworks'

  resources :tags

  resources :artworks do
    member do
      get :like
      post :like
      get :unlike
      post :unlike
    end
  end

  resources :charges

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications/mark_all_read', to: 'notifications#mark_all_read', as: :mark_all_read
  resources :notifications, only: :index

  # Stripe Connect endpoints
  #  - oauth flow
  get '/connect/oauth' => 'stripe#oauth', as: 'stripe_oauth'
  get '/connect/confirm' => 'stripe#confirm', as: 'stripe_confirm'
  get '/connect/deauthorize' => 'stripe#deauthorize', as: 'stripe_deauthorize'
  #  - create accounts
  post '/connect/managed' => 'stripe#managed', as: 'stripe_managed'
  post '/connect/standalone' => 'stripe#standalone', as: 'stripe_standalone'

  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :artworks
    resources :posts
    resources :wallpapers
  end
end
