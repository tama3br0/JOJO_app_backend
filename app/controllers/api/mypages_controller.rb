class Api::MypagesController < ApplicationController
    def show
        @user = current_user
        if @user
            @profile_data = {
                user_id: @user.id,
                user_name: @user.name,
                user_email: @user.email,
                icon: @user.icon
            }
            render json: @profile_data
        else
            render json: { error: "You are not logged in" }, status: :not_found
        end
    end
end
