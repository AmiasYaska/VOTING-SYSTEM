class AddSolidQueueProcessesTable < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_processes do |t|
      t.string :name, null: false
      t.datetime :last_heartbeat_at, null: false
      t.string :supervisor_pid
      t.string :process_pid, null: false
      t.string :hostname, null: false
      t.string :metadata

      t.timestamps
    end

    add_index :solid_queue_processes, :last_heartbeat_at
  end
end