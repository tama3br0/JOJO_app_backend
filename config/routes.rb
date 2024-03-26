Rails.application.routes.draw do
    namespace :api do
        resources :posts, except: [:new, :edit] do
            resources :comments, except: [:new, :edit]
                # GET /api/posts/:post_id/comments          comments#index
                # POST /api/posts/:post_id/comments         comments#create
                # GET /api/posts/:post_id/comments/:id      comments#show
                # PUT /api/posts/:post_id/comments/:id      comments#update
                # DELETE /api/posts/:post_id/comments/:id   comments#destroy
        end
    end
end
