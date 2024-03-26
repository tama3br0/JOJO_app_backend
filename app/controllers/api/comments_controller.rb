class Api::CommentsController < ApplicationController
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
        @comment = @post.comments.new(comment_params)

        if @comment.save
            render json: @comment, status: :created
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    # PUT /api/posts/:post_id/comments/:id
    def update
        if @comment.update(comment_params)
            render json: @comment
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    # DELETE /api/posts/:post_id/comments/:id
    def destroy
        @comment.destroy
        head :no_content
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_comment
        @comment = @post.comments.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:content, :author_name)
    end
end
