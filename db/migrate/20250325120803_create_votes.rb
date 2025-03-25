class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.string :status, default: "draft"

      t.timestamps
    end
  end
end
