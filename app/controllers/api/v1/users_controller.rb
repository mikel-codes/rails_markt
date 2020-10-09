class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    #GET
    def show
        render json: @user
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
        if @user.update(user_params)
            render json: @user, status: 200, location: [:api, @user]
        else
            render json: {errors: @user.errors}, status: 422
        end
    end

    def destroy
        @user.destroy
        head 204
    end

    
    private

    def set_user
       @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:id, :email, :password, :password_confirmation)
    end
end
