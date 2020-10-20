require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} , constraints: {subdomain: 'api'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :update, :create, :destroy] do
        resources :products, only: [:create]
      end
      resources :products, only: [:show, :index]
      resources :sessions, only: [:create, :destroy]
    end
  end
end
