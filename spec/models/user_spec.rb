require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前が入力されていること" do
    user = User.new(
      name: "Jonathan Joestar"
    )

    expect(user).to be_valid
  end

  it "名前が入力されていなければ無効であること" do
    user = User.new(
      name: nil
    )
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  
  it "名前の文字数が20文字であれば有効であること" do
    user = User.new(
      name: "12345678901234567890"
    )
    user.valid?
    expect(user).to be_valid
  end

  it "名前の文字数が21文字であれば無効であること" do
    user = User.new(
      name: "123456789012345678901"
    )
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
  end
end
