class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false # 必須だとけど、null: falseで制約をつける
      t.text :content

      t.timestamps
    end
  end
end
