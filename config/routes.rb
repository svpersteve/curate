Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations", passwords: "passwords", sessions: "sessions" }
  root to: 'pages#index'

  get '/request-email', to: 'users#request_email', as: 'request_email'

  resources :users, path: 'artists' do
    member do
      get :follow
      post :follow
      get :unfollow
      post :unfollow
      get :contact
      post :contact
    end
  end

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  get '/users', to: redirect('/artists')
  get '/feed', to: 'users#home', as: 'updates'

  resources :posts do
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

  resources :artworks
end
