class ApplicationController < ActionController::API
    #prevent csrf attacks by raising an exception
    include ActionController::RequestForgeryProtection
    protect_from_forgery with: :null_session, unless: -> { request.format.json?}
    include Authenticable
end
