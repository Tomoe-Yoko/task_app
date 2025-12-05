require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { User.create!(name: "Tom", email: "test@example.com", password: "password") }

  describe "validation" do
    it "タイトルは必須であること" do
      task = Task.new(title: nil, content: "内容", deadline: Date.tomorrow, user: user)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("を入力してください")
    end
    it "タスク内容は500文字以内なら有効" do
      task = Task.new(title: "title", content: "a" * 500, deadline: Date.tomorrow, user: user)
      expect(task).to be_valid
    end
    it "タスク内容は501文字以上なら無効" do
      task = Task.new(title: "title", content: "a" * 501, deadline: Date.tomorrow, user: user)
      expect(task).not_to be_valid
      expect(task.errors[:content]).to include("は500文字以内で入力してください")
    end
  end
end
