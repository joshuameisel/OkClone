if user.profile_pic
  json.profile_pic_url user.profile_pic.photo_file.url(:thumb)
else
  json.profile_pic_url "/images/default_thumb.gif"
end

json.answer {json.(answer.answer_choice, :body, :id)}

json.acceptable_answers do
  json.ids { json.array!(acceptable_answers) {|acc_answer| acc_answer.id} }
end