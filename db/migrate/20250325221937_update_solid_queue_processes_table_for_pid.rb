class UpdateSolidQueueProcessesTableForPid < ActiveRecord::Migration[8.0]
  def change
    # Remove the old columns
    remove_column :solid_queue_processes, :supervisor_pid, :string
    remove_column :solid_queue_processes, :process_pid, :string

    # Add the new pid column
    add_column :solid_queue_processes, :pid, :string, null: false
  end
end