class PostsController < ApplicationController

    def index
        @posts = Post.all
    end

    def show 
        @post = Post.find(params[:id])
    end
    def new
        @post = Post.new
    end
    def create

    end
    def create
        @post = Post.new(post_params)
        @post.user = User.first
        if @post.save
            flash[:sucess] = "Post criado com sucesso"
            redirect_to  post_path(@post)
        else
            render 'new'
        end
    end
    private 
        def set_post
            @post = Post.find(params[:id])
        endfv0    
        end
        def post_params
            params.require(:post).permit(:name, :description)
        end
end
