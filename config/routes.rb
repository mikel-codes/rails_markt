Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #api definition
  namespace :api, defaults: {format: :json} , constraints: {subdomain: 'api'} do
    
  end
end
