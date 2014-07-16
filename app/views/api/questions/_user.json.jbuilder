if user.profile_pic
  json.profile_pic_url user.profile_pic.photo_file.url[:thumb]
end

json.answer do
  json.(answer.answer_choice, :body, :id)
end