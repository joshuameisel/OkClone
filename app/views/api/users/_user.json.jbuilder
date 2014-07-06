json.(user, :id, :username, :gender, :orientation, :min_age, :max_age, :dob,
  :country, :session_token, :zip_code, :email, :password_digest, :created_at,
  :updated_at, :age, :profile, :likes)

<<<<<<< HEAD
=======
if user.profile_pic
  json.profile_pic do
    json.partial!("api/photos/photo", :photo => user.profile_pic)
  end
end

>>>>>>> refactor Api::UsersController#show
json.photos(photos) do |photo|
  json.partial!("api/photos/photo", :photo => photo)
end