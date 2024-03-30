class Api::CommentsController < ApplicationController
    before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :set_post
    before_action :set_comment, only: [:show, :update, :destroy]

    # GET /api/posts/:post_id/comments
    def index
        comments = @post.comments
        render json: comments
    end

    # GET /api/posts/:post_id/comments/:id
    def show
        render json: @comment
    end

    # POST /api/posts/:post_id/comments
    def create
        puts request.raw_post

        puts params.inspect

        @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))

        if @comment.save
            render json: @comment, status: :created
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    # PUT /api/posts/:post_id/comments/:id
    def update
        if @comment.user == current_user && @comment.update(comment_params)
            render json: @comment
        else
            render json: { error: 'あなたには編集する権限がありません' }, status: :unprocessable_entity
        end
    end

    # DELETE /api/posts/:post_id/comments/:id
    def destroy
        if @comment.user == current_user
            @comment.destroy
            head :no_content
        else
            render json: { error: 'あなたには削除する権限がありません' }, status: :unprocessable_entity
        end
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_comment
        @comment = @post.comments.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:content, :author_name, :post_id)
    end
end
