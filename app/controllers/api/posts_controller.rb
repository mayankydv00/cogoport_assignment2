module Api
    class PostsController < ApplicationController
      before_action :authenticate
      before_action :set_post, only: [:show, :update, :destroy]
  
      def index
        
        @posts = Post.all

        if params[:author]
          @posts = @posts.where(author: params[:author])
        end

        if params[:category]
          @posts = @posts.where(category: params[:category])
        end
  
        if params[:start_date]
          start_date = Date.parse(params[:start_date])
          @posts = @posts.where('created_at >= ?', start_date.beginning_of_day)
        end
  
        if params[:end_date]
          end_date = Date.parse(params[:end_date])
          @posts = @posts.where('created_at <= ?', end_date.end_of_day)
        end

      
      @posts = @posts.includes(:comments) 
      @posts = @posts.to_json(include: :comments)


        render json: @posts

      end
      
      def show
      
        @posts = Post.includes(:comments).find(params[:id])
        render json: @posts.to_json(include: :comments)
      end
    
      def create
        @post = Post.new(post_params)
        @post.author = @user.id
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
  
      def filter_by_author(posts, author)
        posts.where(author: author)
      end
  
      def filter_by_date(posts, start_date, end_date)
        posts.where(created_at: start_date..end_date)
      end

      def set_post
        @post = Post.find(params[:id])
      end
  
      def post_params
        params.permit(:author, :img , :title, :no_of_likes, :category)
      end

      def authenticate

        key = request.headers['Authorization']
        token = key.split(' ').last if key 
    
        begin
          decoded_token = JWT.decode(token, 'ASDFGH', true, algorithm: 'HS256')
          render json: {error: "Your token is invalid"} if !decoded_token[0]['author']
          @user = User.find(decoded_token[0]['author'])
        rescue JWT::DecodeError
          render json: { error: "Unauthorized user" }, status: :unauthorized
        end
    end

  end

end
  