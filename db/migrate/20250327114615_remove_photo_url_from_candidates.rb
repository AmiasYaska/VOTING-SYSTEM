class RemovePhotoUrlFromCandidates < ActiveRecord::Migration[8.0]
  def change
    remove_column :candidates, :photo_url, :string
  end
end
