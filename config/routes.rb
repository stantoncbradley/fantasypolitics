Rails.application.routes.draw do
  resources :bills

  resources :sponsors

  resources :politician_bills

  resources :politicians

  resources :rosters

  resources :teams

  resources :trades

  get 'leagues/new', to: 'leagues#new', as: 'new_league'
  get 'leagues/:id/edit', to: 'leagues#edit', as: 'edit_league'
  patch 'leagues/:id', to: 'leagues#update', as: 'update_league'
  get 'leagues', to: 'leagues#index', as: 'leagues'
  get 'leagues/:id', to: 'leagues#show', as: 'league'
  post 'leagues', to: 'leagues#create', as: 'create_league'

  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root to: 'users#show', as: 'authenticated_root'
  end

  root to: 'home#index'

  get 'users/:id', to: 'users#show', as: 'user_show'

  get '/import/:method', to: 'import#sunlight'

  get 'invites/new/:league_id', to: 'invites#new', as: 'new_invite'
  post 'invites', to: 'invites#create', as: 'create_invite'
  get 'invites/:session_key', to: 'invites#show', as: 'invite'


end
