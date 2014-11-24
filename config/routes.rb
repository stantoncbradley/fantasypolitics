Rails.application.routes.draw do
  resources :bills

  resources :sponsors

  resources :politician_bills

  resources :politicians

  resources :rosters

  resources :teams

  get 'leagues/new', to: 'leagues#new', as: 'new_league'
  get 'leagues/:id/edit', to: 'leagues#edit', as: 'edit_league'
  patch 'leagues/:id', to: 'leagues#update', as: 'update_league'
  get 'leagues', to: 'leagues#index', as: 'leagues'
  get 'leagues/:id', to: 'leagues#show', as: 'league'
  post 'leagues', to: 'leagues#create', as: 'create_league'

  devise_for :users, controllers: { registrations: 'registrations'}

  authenticated :user do
    root to: 'users#show', as: 'authenticated_root'
  end

  root to: 'home#index'

  get 'users/:id', to: 'users#show', as: 'user_show'

  get '/import/:method', to: 'import#sunlight'

  get '/invites/:invite_id', to: 'invites#show', as: 'invite_show'


end
