class RemoveSolidQueueTables < ActiveRecord::Migration[8.0] # Class name matches filename
  def up
    # Drop tables in reverse order of creation to respect foreign keys
    drop_table :solid_queue_semaphores, if_exists: true, force: :cascade
    drop_table :solid_queue_processes, if_exists: true, force: :cascade
    drop_table :solid_queue_scheduled_executions, if_exists: true, force: :cascade
    drop_table :solid_queue_failed_executions, if_exists: true, force: :cascade
    drop_table :solid_queue_claimed_executions, if_exists: true, force: :cascade
    drop_table :solid_queue_ready_executions, if_exists: true, force: :cascade
    drop_table :solid_queue_blocked_executions, if_exists: true, force: :cascade
    drop_table :solid_queue_jobs, if_exists: true, force: :cascade
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end