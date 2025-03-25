class CreatePositions < ActiveRecord::Migration[8.0]
  def change
    create_table :positions do |t|
      t.string :name
      t.text :description
      t.integer :max_winners, default: 1
      t.integer :priority
      t.boolean :voting_open, default: true

      t.timestamps
    end
  end
end
