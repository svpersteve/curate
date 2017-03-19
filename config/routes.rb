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
      get :like
      post :like
      get :unlike
      post :unlike
    end
  end

  get "/artists/:id/user-activity" => 'users#activity', as: 'user_activity'
  get "/artists/:id/user-pages" => 'users#posts', as: 'user_posts'

  resources :tags
end
