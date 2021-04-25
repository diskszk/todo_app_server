class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :contents
      t.string :is_done
      t.string :boolean

      t.timestamps
    end
  end
end
