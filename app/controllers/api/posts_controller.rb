class Api::PostsController < ApplicationController

    # GET /api/posts
    def index
        posts = Post.all
        render json: posts.map { |post| post.as_json.merge(created_at: post.created_at.strftime('%B %d, %Y')) }, status: :ok
    end

    # GET /api/posts/:id
    def show
        post = Post.find(params[:id])
        render json: post.as_json.merge(created_at: post.created_at.strftime('%B %d, %Y'))
    end

    # POST /api/posts
    def create
        post = Post.new(post_params)
        if post.save
            render json: post, status: :created
        else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # PUT/PATCH api/posts/:id
    def update
        post = Post.find(params[:id])
        if post.update(post_params)
            render json: post
        else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE api/posts/:id
    def destroy
        post = Post.find(params[:id])
        image = post.image
        data = Post.where(image: image.url)
        # 画像のデータを条件に合わせて消す
        if data.count < 2
            # 画像データを消す処理
            FileUtils.rm("#{Rails.root}/public#{post.image.url}") if post.image.present?
        end
        post.destroy
        render json: { message: 'Post deleted successfully' }, status: :ok
    end

    private

    def post_params
        params.require(:post).permit(:title, :image)
    end
end
