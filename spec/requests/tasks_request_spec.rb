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
        @user.tasks.create(
          title: "Test Task#{i}",
          id: i
        )
      end
  
      get @uri
      json = JSON.parse(response.body)
      expect(json.count).to eq(9)
    end
  end

  describe "GET /api/v1/users/user_id/tasks/task_id" do
    before do
      @user = create(:user)
      @uri = "/api/v1/users/#{@user.id}/tasks"
    end
    
    it "リクエストが成功すること" do
      task = @user.tasks.create(title: "Test Task")
      get "#{@uri}/#{task.id}"
      expect(response.status).to eq(200)
    end

    it "存在しないリソースにアクセスを試みた場合404を返すこと" do
    end
    it "タスク情報を1件取得できること"
  end

  describe "POST /api/v1/users/user_id/tasks" do
    it "リクエストが成功すること" do
    end

    it "データが作成されること"

  end

  describe "PUT /api/v1/users/user_id/tasks/task_id" do
    it "リクエストが成功すること" do
    end
    it "存在しないリソースにアクセスを試みた場合404を返すこと" do
    end

    it "データが変更されていること"

  end

  describe "DELETE /api/v1/users/user_id/tasks/task_id" do
    it "リクエストが成功すること" do
    end
    it "存在しないリソースにアクセスを試みた場合404を返すこと" do
    end
    it "タスクが削除されること"
  end
 



end
