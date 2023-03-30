class PostsController < ApplicationController
    before_action :require_login, only:[:new,:create]
    def home
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    private

    def require_login
        unless user_signed_in?
            flash[:alert] = "You must be logged in to access this section"
            redirect_to new_user_session_path # halts request cycle
        end

    end

    def post_params
        params.require(:post).permit(:title,:body)
    end

end
