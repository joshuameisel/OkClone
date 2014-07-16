json.(user, :id, :username, :gender, :orientation, :min_age, :max_age, :dob,
  :country, :session_token, :zip_code, :email, :password_digest, :created_at,
  :updated_at, :age, :profile, :likes)

if user.profile_pic
  json.profile_pic do
    json.partial!("api/photos/photo", :photo => user.profile_pic)
  end
end

json.photos(photos) do |photo|
  json.partial!("api/photos/photo", :photo => photo)
end

json.match_percentage current_user.match_percentage(user) if current_user