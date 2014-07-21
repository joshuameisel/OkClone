if user.profile_pic
  json.profile_pic_url user.profile_pic.photo_file.url(:thumb)
else
  json.profile_pic_url "/images/default_thumb.gif"
end

json.answer {json.(answer.answer_choice, :body, :id)} if answer

json.acceptable_answers do
  json.array!(acceptable_answers) do |acc_answer|
    json.answer_choice_id acc_answer.answer_choice_id
  end
end