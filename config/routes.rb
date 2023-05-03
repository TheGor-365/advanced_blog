Rails.application.routes.draw do
  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'u/:id', to: 'users#profile', as: 'user'
  get 'search', to: 'search#index'

  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/show_post/:id', to: 'admin#show_post', as: 'admin_post'
  end

  resources :posts do
    resources :comments
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :after_signup
end
