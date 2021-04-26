require 'rails_helper'

RSpec.describe Task, type: :model do

  before do
    @user = User.new(
      name: "Jonathan Joestar"
    )
    @user.save
  end
  
  it "タイトルが入力されていること" do
    task = @user.tasks.create(
      title: "BIZARRE ADVENTURE"
    )

    task.valid?
    expect(task).to be_valid
  end

  it "タイトルが入力されていなければ無効であること" do
    task = @user.tasks.create(title: nil)

    task.valid?
    expect(task.errors[:title]).to include("can't be blank")
  end

  it "内容が未入力でも有効であること" do
    task = @user.tasks.create(
      title: "BIZARRE ADVENTURE",
      contents: nil
    )
    task.valid?
    expect(task).to be_valid
  end
    
  it "内容の文字数が50文字以内であれば有効であること"do
    task = @user.tasks.create(
      title: "BIZARRE ADVENTURE",
      contents: "12345678901234567890123456789012345678901234567890"
    )
    task.valid?
    expect(task).to be_valid
  end

  
  it "内容の文字数が51文字以上であれば無効であること" do
    task = @user.tasks.create(
      title: "BIZARRE ADVENTURE",
      contents: "123456789012345678901234567890123456789012345678901"
    )
    task.valid?
    expect(task.errors[:contents]).to include("is too long (maximum is 50 characters)")
  end
end
