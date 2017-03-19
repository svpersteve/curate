Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations", passwords: "passwords", sessions: "sessions" }
  root to: 'pages#index'

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
