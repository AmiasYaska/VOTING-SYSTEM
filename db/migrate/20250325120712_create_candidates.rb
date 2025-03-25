class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates do |t|
      t.references :position, null: false, foreign_key: true
      t.string :name
      t.string :qualification
      t.string :photo_url

      t.timestamps
    end
  end
end
