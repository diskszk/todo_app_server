require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  describe "GET /api/v1/users/user_id/tasks" do
    before do
      @user = create(:user)
      user_id = @user.id
      @uri = "/api/v1/users/#{user_id}/tasks"
    end
  
    it "リクエストが成功すること" do
      get @uri
      expect(response.status).to eq(200)
    end
  
    it "タスク一覧が取得できること"do

      for i in 1...10 do
        @user.tasks.create(title: "Test Task")
      end
  
      get @uri
      json = JSON.parse(response.body)
      # expect(json.length).to eq(10) 
      expect(json.length).to eq(7) #
    end
  end

  describe "GET /api/v1/users/user_id/tasks/task_id"

  describe "POST /api/v1/users/user_id/tasks"

  describe "PUT /api/v1/users/user_id/tasks/task_id"

  describe "DELETE /api/v1/users/user_id/tasks/task_id"
 



end
