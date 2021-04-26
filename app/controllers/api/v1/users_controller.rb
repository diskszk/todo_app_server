module Api
  module V1  
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]
    
      def index
        users = User.order(created_at: :desc)
        render json: users
      end
    
      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render json: @user.errors
        end
      end
    
      def user_params
        params.permit(:name)
      end
    end    
  end
end
