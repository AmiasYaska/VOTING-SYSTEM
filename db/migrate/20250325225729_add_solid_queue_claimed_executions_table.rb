class AddSolidQueueClaimedExecutionsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_claimed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.bigint :process_id, null: false
      t.datetime :created_at, null: false
    end

    add_foreign_key :solid_queue_claimed_executions, :solid_queue_processes, column: :process_id
  end
end