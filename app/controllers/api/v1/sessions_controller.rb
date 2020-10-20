class Api::V1::SessionsController < ApplicationController
    def create
        user_password = params[:session][:password]
        user_email = params[:session][:email]
        user = user_email.present? && User.find_by(email: user_email)
        if user.valid_password? user_password
            sign_in user, store: false
            user.generate_authentication_token!
            user.save
            render json: user, status: 200, location: [:api, user]
        else
            render json: {errors: "invalid email or password"}, status: 422
        end
    end

    def destroy
        # once a section is deleted , automatically create a new auth and save
        user = User.find_by auth_token: auth_token
        user.generate_authentication_token!
        user.save
        head 204
    end
end
