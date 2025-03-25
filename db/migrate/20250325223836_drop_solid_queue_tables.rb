class DropSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    # Drop dependent tables first
    execute "DROP TABLE IF EXISTS solid_queue_failed_executions CASCADE"
    execute "DROP TABLE IF EXISTS solid_queue_blocked_executions CASCADE"
    execute "DROP TABLE IF EXISTS solid_queue_scheduled_executions CASCADE"
    execute "DROP TABLE IF EXISTS solid_queue_recurring_executions CASCADE"

    # Drop solid_queue_jobs after its dependent tables are gone
    execute "DROP TABLE IF EXISTS solid_queue_jobs CASCADE"

    # Drop solid_queue_processes (may have self-referential foreign key)
    execute "DROP TABLE IF EXISTS solid_queue_processes CASCADE"
  end
end