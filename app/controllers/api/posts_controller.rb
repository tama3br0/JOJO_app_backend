class Api::PostsController < ApplicationController
    before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :set_post, only: [:show, :update, :destroy]

    # GET /api/posts
    def index
        posts = Post.order(created_at: :desc)
        render json: posts.map { |post| post.as_json.merge(created_at: post.created_at.strftime('%B %d, %Y')) }, status: :ok
    end

    # GET /api/posts/:id
    def show
        render json: @post.as_json.merge(created_at: @post.created_at.strftime('%B %d, %Y'))
    end

    # POST /api/posts
    def create
        logger.debug "Received parameters: #{params.inspect}"
        # current_userがhas_manyしているpostsのこと => postsテーブルのこと
        post = current_user.posts.new(post_params)
        if post.save
            render json: post, status: :created
        else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # PUT/PATCH api/posts/:id
    def update
        # Postモデルがbelongs_toしているuserのこと
        if @post.user == current_user && @post.update(post_params)
            render json: @post
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE api/posts/:id
    def destroy
        if @post.user == current_user
            @post.destroy
            render json: { message: '削除できました' }, status: :ok
        else
            render json: { error: 'あなたにはこの投稿を削除する権限がありません' }, status: :unprocessable_entity
        end
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :image)
    end
end
