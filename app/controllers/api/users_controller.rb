module Api
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
  
      def index
        @users = User.all
        render json: @users
      end
    
      def show

      @user = User.includes(posts: :comments).find(params[:id])
      render json: @user.to_json(include: { posts: { include: :comments } })
      
    
      end
  
      def create
        @user = User.new(user_params)
  
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages } , status: :unprocessable_entity
        end
      end
  
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
  
      def destroy
        @user.destroy
      end
  
      private
  
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.permit(:name, :email , :password , :img)
      end
    end
  end
  