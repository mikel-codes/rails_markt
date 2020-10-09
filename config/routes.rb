require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #api definition
  namespace :api, defaults: {format: :json} , constraints: {subdomain: 'api'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :update, :create, :destroy]
    end
  end
end
