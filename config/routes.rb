Rails.application.routes.draw do
  resources :bills

  resources :cosponsors

  resources :politician_bills

  resources :politicians

  resources :rosters

  resources :league_users

  resources :leagues

  devise_for :users
  root 'home#index'

end
