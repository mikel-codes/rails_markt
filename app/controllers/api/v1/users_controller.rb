class Api::V1::UsersController < ApplicationController
    #GET
    def show
        render json: User.find(params[:id])
    end

    def create
        user = User.new user_params
        if user.valid?
            user.save!
            render json: user, status: 201, location: [:api, user]
        else
            render json: {errors: user.errors}, status: 422
        end
    end

    #PUT/PATCH
    def update
        
    end

    private
    def user_params
        params.require(:user).permit(:id, :email, :password, :password_confirmation)
    end
end
