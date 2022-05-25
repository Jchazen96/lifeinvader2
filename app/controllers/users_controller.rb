class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def new
        user = User.new(user_params)
        pp user
        if user.save
            render json: user, status: 200
        else
            render json: {errors: user.errors.full_messages}, status: 422
        end
    end

    def login
        user = User.find_by(email: params[:email], password: params[:password])
        if user
            render json: user, status: 200
        else
            render json: {error: 'Invalid email or password'}, status: 404
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :username
        )
    end
end
