class Api::V1::UsersController < ApplicationController
    #GET
    def show
        render json: User.find(params[:id])
    end

    #PUT/PATCH
    def update
        
    end
end
