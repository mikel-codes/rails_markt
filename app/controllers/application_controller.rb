class ApplicationController < ActionController::API
    #prevent csrf attacks by raising an exception
    protect_from_forgery  unless: -> { request.format.json?}
end
