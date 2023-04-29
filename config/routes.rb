Rails.application.routes.draw do
  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'u/:id', to: 'users#profile', as: 'user'

  resources :posts

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
