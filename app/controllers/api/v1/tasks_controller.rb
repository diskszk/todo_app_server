module Api
  module V1  
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update]

      # GET /api/v1/users/:user_id/tasks
      # BUG: タスクIDがユーザーIDと一致する一見しか取得していない
      def index
        user = User.find(params[:user_id])
        render json: user.tasks
      end

      # GET /api/v1/users/:user_id/tasks/:task_id
      def show
        render json: @task
      end

      # POST /api/v1/users/:user_id/tasks
      def create
        @task = Task.new(task_params)

        if @task.save
          render json: @task
        else
          render json: @task.errors
        end
      end

      # PUT /api/v1/users/:user_id/tasks/:task_id
      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors
        end
      end

      # DELETE /api/v1/users/:user_id/tasks/:task_id

      private
      def set_user
        @user = User.find(params[:user_id])
      end

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.permit(:title, :user_id, :contents)
      end

    end    
  end
end
