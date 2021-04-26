require 'rails_helper'

RSpec.describe "Users", type: :request do

  uri = "/api/v1/users"
  
  describe "GET /api/v1/users" do
    before do
      create_list(:user, 10)
    end

    it "リクエストが成功すること" do
      get uri
      expect(response.status).to eq 200
    end

    it "ユーザー一覧が取得できること" do
      get uri
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
      expect(json['name']).to eq(@user.name)
    end
  end

  
end
