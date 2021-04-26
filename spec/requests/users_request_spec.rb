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
      expect(json["name"]).to eq(@valid_params.name)
    end

    it "nullでは書き換えられないこと" do
      user_name = @user.name
      put "#{url}/#{@user.id}", params: {name: nil}
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(user_name)
    end
  end
end
