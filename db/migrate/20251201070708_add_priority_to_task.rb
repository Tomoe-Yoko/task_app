class AddPriorityToTask < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :priority, :integer, null: false, default: 0
  end
end
