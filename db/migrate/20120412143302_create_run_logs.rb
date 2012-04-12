class CreateRunLogs < ActiveRecord::Migration
  def change
    create_table :run_logs do |t|
      t.integer :time_ran

      t.timestamps
    end
  end
end
