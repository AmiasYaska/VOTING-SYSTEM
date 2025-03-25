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

    add_index :solid_queue_jobs, :queue_name
    add_index :solid_queue_jobs, :run_at
    add_index :solid_queue_jobs, :priority
  end
end