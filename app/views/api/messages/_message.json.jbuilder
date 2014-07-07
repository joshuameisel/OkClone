json.(message, :id, :body, :sender_id, :recipient_id, :created_at, :updated_at)

author = message.sender

json.author do
  json.(author, :id)
  if author.profile_pic
    json.profile_pic_url author.profile_pic.photo_file.url(:thumb)
  end
end