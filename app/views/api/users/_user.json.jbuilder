json.(user, :id, :username, :gender, :orientation, :min_age, :max_age, :dob,
  :country, :session_token, :zip_code, :email, :password_digest, :created_at,
  :updated_at, :age, :profile, :likes)

json.photos(photos) do |photo|
  json.partial!("api/photos/photo", :photo => photo)
end