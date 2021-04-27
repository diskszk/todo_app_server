require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  before(:each) do
    @user = create(:user)
    @uri = "/api/v1/users/#{@user.id}/tasks"
  end

  describe "GET /api/v1/users/user_id/tasks" do
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
      @task = @user.tasks.create(title: "Test Task")
    end

    it "リクエストが成功すること" do
      get "#{@uri}/#{@task.id}"
      expect(response.status).to eq(200)
    end

    it "存在しないリソースにアクセスを試みた場合404を返すこと" do
      get "#{@uri}/404"
      json = JSON.parse(response.body)
      expect(json['status']).to eq(404)
    end

    it "タスク情報を1件取得できること" do
      get "#{@uri}/#{@task.id}"
      json = JSON.parse(response.body)
      expect(json["title"]).to eq(@task.title)
    end
  end

  describe "POST /api/v1/users/user_id/tasks" do
    before do
      @valid_params = {title: "Valid Task"}
    end
    
    it "リクエストが成功すること" do
      post "#{@uri}", params: @valid_params
      expect(response.status).to eq(200)
    end

    it "データが作成されること" do
      expect {
        post "#{@uri}", params: @valid_params
      }.to change(Task, :count).by(+1)
    end
  end

  describe "PUT /api/v1/users/user_id/tasks/task_id" do
    before do
      @valid_params = {title: "Valid Task"}
      @task = @user.tasks.create(title: "Test Title")
    end

    it "リクエストが成功すること" do
      put "#{@uri}/#{@task.id}", params: @valid_params
      expect(response.status).to eq(200)
    end

    it "存在しないリソースにアクセスを試みた場合404を返すこと" do
      put "#{@uri}/404", params: @valid_params
      json = JSON.parse(response.body)
      expect(json['status']).to eq(404)
    end

    it "データが変更されていること" do
      put "#{@uri}/#{@task.id}", params: @valid_params
      json = JSON.parse(response.body)
      expect(json['title']).to eq("Valid Task")
    end

  end

  describe "DELETE /api/v1/users/user_id/tasks/task_id" do
    before do
      @task = @user.tasks.create(title: "Test Title")
    end
    
    it "リクエストが成功すること" do
       delete "#{@uri}/#{@task.id}"
       expect(response.status).to eq(200)
    end

    it "存在しないリソースにアクセスを試みた場合404を返すこと" do
      delete "#{@uri}/404"
      json = JSON.parse(response.body)
      expect(json['status']).to eq(404)
    end

    it "タスクが削除されること" do
      expect {
        delete "#{@uri}/#{@task.id}"
      }.to change(Task, :count).by(-1)
    end
  end
 
end
