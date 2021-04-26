require 'rails_helper'

RSpec.describe Task, type: :model do
  it "タイトルが入力されていること"
  it "タイトルが入力されていなければ無効であること"
  it "内容が未入力でも有効であること"
  it "内容の文字数が50文字以内であれば有効であること"
  it "内容の文字数が51文字以上であれば無効であること"
end
