require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users" do
    before do
      create_list(:user, 10)
    end

    it "リクエストが成功すること" do
      get "/api/v1/users"
      expect(response.status).to eq 200
    end

    it "ユーザー一覧が取得できること" do
      get "/api/v1/users"

      expect(json.length).to eq(10)
    end
  end
end
