require 'rails_helper'
RSpec.describe "Tasks", type: :system do
  include Warden::Test::Helpers

  Warden.test_mode!

  let(:user) { User.create!(name: "Tom", email: "test@example.com", password: "password") }

  before do
    login_as(user, scope: :user)
  end

  describe "タスクを新規作成できる" do
    it "一覧に表示される" do
      visit tasks_path
      click_on "新規作成"
      fill_in "タイトル", with: "新しいタスク"
      fill_in "タスク内容", with: "タスクの内容"
      fill_in "終了期限", with: Date.tomorrow
      click_on "作成"
      expect(page).to have_current_path tasks_path
      expect(page).to have_content "タスクが作成されました"
      expect(page).to have_content "新しいタスク"
      expect(page).to have_content "タスクの内容"
    end
  end
end
