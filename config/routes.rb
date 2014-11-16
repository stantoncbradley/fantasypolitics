Rails.application.routes.draw do
  resources :bills

  resources :cosponsors

  resources :politician_bills

  resources :politicians

  resources :rosters

  resources :league_users

  resources :leagues

  get 'users/:id', to: 'users#show', as: 'user_show'

  devise_for :users
  root 'home#index', as: 'landing_page'

  get '/import/:method', to: 'import#sunlight'

end
