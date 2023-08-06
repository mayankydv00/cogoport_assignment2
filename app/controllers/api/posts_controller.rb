module Api
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]
  
      def index
        @posts = Post.includes(:comments)
        render json: @posts.to_json(include: :comments) 
      end
      
      def show
        render json: @post
      end
    
      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
  
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
  
      def destroy
        @post.destroy
        head :no_content
      end
  
      private
  
      def set_post
        @post = Post.find(params[:id])
      end
  
      def post_params
        params.permit(:author, :image, :title, :no_of_likes, :category)
      end
    end

  end
  