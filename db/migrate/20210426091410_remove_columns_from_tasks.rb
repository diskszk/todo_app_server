class RemoveColumnsFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :is_done, :string
    remove_column :tasks, :string, :string
    remove_column :tasks, :boolean, :string
  end
end
