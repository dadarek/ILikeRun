class AddUserIdToRunLogs < ActiveRecord::Migration
  def up
    RunLog.delete_all
    add_column :run_logs, :user_id, :integer
    change_column :run_logs, :user_id, :integer, null: false
  end

  def down
    remove_column :run_logs, :user_id
  end
end
