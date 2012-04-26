class AddDateRanToRunLogs < ActiveRecord::Migration
  def change
    add_column :run_logs, :date_ran, :date
  end
end
