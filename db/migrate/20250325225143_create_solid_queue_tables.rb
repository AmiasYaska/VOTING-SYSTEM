class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :class_name, null: false
      t.text :arguments
      t.integer :priority, default: 0, null: false
      t.datetime :run_at, null: false
      t.integer :attempts, default: 0, null: false
      t.datetime :locked_at
      t.string :locked_by
      t.datetime :finished_at
      t.text :error

      t.timestamps
    end

    create_table :solid_queue_failed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.text :error
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_processes do |t|
      t.string :name, null: false
      t.datetime :last_heartbeat_at, null: false
      t.string :pid, null: false
      t.string :hostname, null: false
      t.string :metadata
      t.string :kind, null: false, default: "worker"
      t.bigint :supervisor_id

      t.timestamps
    end

    create_table :solid_queue_blocked_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.datetime :expires_at, null: false
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_scheduled_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.datetime :run_at, null: false
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_recurring_executions do |t|
      t.string :task_key, null: false
      t.datetime :run_at, null: false
      t.datetime :created_at, null: false
    end

    add_index :solid_queue_jobs, :queue_name
    add_index :solid_queue_jobs, :run_at
    add_index :solid_queue_jobs, :priority
    add_index :solid_queue_processes, :last_heartbeat_at
    add_foreign_key :solid_queue_processes, :solid_queue_processes, column: :supervisor_id
    add_index :solid_queue_blocked_executions, :expires_at
    add_index :solid_queue_scheduled_executions, :run_at
    add_index :solid_queue_recurring_executions, :task_key, unique: true
    add_index :solid_queue_recurring_executions, :run_at
  end
end