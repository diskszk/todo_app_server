require 'rails_helper'

RSpec.describe "Users", type: :request do

  uri = "/api/v1/users"
  
  describe "GET /api/v1/users" do
    before do
      create_list(:user, 10)
    end

    it "リクエストが成功すること" do
      get uri
      expect(response.status).to eq(200)
    end

    it "ユーザー一覧が取得できること" do
      get uri
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end
  end

  describe "GET /api/v1/users/:id" do
    before do
      @user = create(:user)
    end

    it "リクエストが成功すること" do
      get "#{uri}/#{@user.id}"
      expect(response.status).to eq(200)
    end

    it "ユーザー情報を1件取得できること" do
      get "#{uri}/#{@user.id}"
      json = JSON.parse(response.body)
      expect(json['name']).to eq(@user.name)
    end
  end

  describe "POST /api/v1/users" do
    before do
      @valid_params = {name: "user_name"}
    end

    it "リクエストが成功すること" do
      post "#{uri}", params: @valid_params
      expect(response.status).to eq(200)
    end

    it "データが作成されること" do
      expect {
        post "#{uri}", params: @valid_params
      }.to change(User, :count).by(+1)
    end

    it "バリデーションエラーの場合データが作成されないこと" do
      expect {
        post "#{uri}", params: {name: nil}
      }.to change(User, :count).by(0)
    end
  end

  describe "PUT /api/v1/users/:id" do
    before do
      @valid_params = {name: "user_name"}
      @user = create(:user)
    end

    it "リクエストが成功すること" do
      put "#{uri}/#{@user.id}", params: @valid_params
      expect(response.status).to eq(200)
    end

    it "データが変更されていること" do
      put "#{uri}/#{@user.id}", params: @valid_params
      json = JSON.parse(response.body)
      expect(json['name']).to eq("user_name")
    end

    it "nullでは書き換えられないこと" do
      user_name = @user.name
      put "#{uri}/#{@user.id}", params: {name: nil}
      json = JSON.parse(response.body)
      expect(json['name']).to_not eq(nil)
    end
  end

  describe "DELETE /api/v1/users/:id" do
    before do
      @user = create(:user)
    end

    it "リクエストが成功すること" do
      delete "#{uri}/#{@user.id}"
      expect(response.status).to eq(200)
    end

    it "ユーザーが削除されること" do
      expect {
        delete "#{uri}/#{@user.id}"
      }.to change(User, :count).by(-1)
    end

    it "存在しないIDが渡された場合404を返すこと" do

      user_id = @user.id
      
      # 一旦削除する
      delete "#{uri}/#{user_id}"
      expect(response.status).to eq(200)

      # 再度削除する
      delete "#{uri}/#{user_id}"
      json = JSON.parse(response.body)
      expect(json['status']).to eq(404)
    end
  end
end
