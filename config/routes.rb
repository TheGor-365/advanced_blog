Rails.application.routes.draw do
  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'u/:id', to: 'users#profile', as: 'user'

  resources :posts do
    resources :comments
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
