class Api::MypagesController < ApplicationController
    # before_action :post_params

    def show
        @user = current_user
        @posts = current_user.posts
        puts @profile_data
        if @user
            @profile_data = {
                user_id: @user.id,
                user_name: @user.name,
                user_email: @user.email,
                icon: @user.icon,
                posts: @posts.map { |post| post.as_json.merge(created_at: post.created_at.strftime('%B %d, %Y')) }, status: :ok
            }
            render json: @profile_data
        else
            render json: { error: "You are not logged in" }, status: :not_found
        end
    end

        # private

        # def post_params
        #     params.require(:post).permit(:title, :image)
        # end
end
