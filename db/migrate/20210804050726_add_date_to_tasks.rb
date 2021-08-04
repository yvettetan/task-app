class AddDateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :due_at, :datetime
  end
end
