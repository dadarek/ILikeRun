class CopyRunLogsCreatedAtToDateRan < ActiveRecord::Migration
  def up
    RunLog.all.each{ |run_log|
      run_log.date_ran = run_log.created_at
      run_log.save!
    }
  end

  def down
  end
end
