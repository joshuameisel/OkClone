class AddPhotoFileColumnsToPhotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :photo_file
  end
end
