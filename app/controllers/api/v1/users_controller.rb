module Api
  module V1  
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
    
      # GET /api/v1/users
      def index
        users = User.order(created_at: :desc)
        render json: users
      end

      # GET /api/v1/users/:id
      def show
        render json: @user
      end
    
      # POST /api/v1/users
      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render json: @user.errors
        end
      end
    
      # PUT /api/v1/users/:id
      # DELETE /api/v1/users/:id
      
      private
      def set_user
        @user = User.find(params[:id])
      end
      
      def user_params
        params.permit(:name)
      end
    end    
  end
end
