if user.profile_pic
  json.profile_pic_url user.profile_pic.photo_file.url[:thumb]
end

json.answers do
	json.array!(questions) do |question|
    answer = user.answer_choices.where(question_id: question.id).first
    json.body (answer ? answer.body : "")
	end
end