class RemoveNullFalseFromPhotosUserId < ActiveRecord::Migration
  def up
    remove_column :photos, :photo_id
    add_column :photos, :photo_id, :integer
  end

  def down
    remove_column :photos, :photo_id
    add_column :photos, :photo_id, :integer, null: false
  end
end
