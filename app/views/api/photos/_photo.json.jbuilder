json.(photo, :created_at, :updated_at, :photo_file_file_name,
  :photo_file_content_type, :photo_file_file_size, :photo_file_updated_at,
  :photo_id)

json.photo_file do
  json.url do
    json.full photo.photo_file.url(:full)
    json.profile photo.photo_file.url(:profile)
    json.index photo.photo_file.url(:index)
  end
end