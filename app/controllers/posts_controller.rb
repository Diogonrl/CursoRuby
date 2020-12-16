class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :edit]
    def index
        @posts = Post.all
    end

    def show 
    end
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user = User.first
        if @post.save
            flash[:info] = "Post criado com sucesso"
            redirect_to  post_path(@post)
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            flash[:success] = "Post atualizado com sucesso"
            redirect_to post_path(@post)
        else
            render 'edit'
        end
    end

    def delete
        Post.find(params[:id]).destroy
        flash[:success] = "post deleted successfully"
        redirect_to posts_path
    end

    private 
        def set_post
            @post = Post.find(params[:id]) 
        end
        def post_params
            params.require(:post).permit(:name, :description)
        end
end
