@users.each do |user|
  current_user == user ? json.current_user : json.user do
    json.partial!(
      "user",
      user: user,
      answer: @answers[user],
      acceptable_answers: @acceptable_answers[user]
    )
  end
end

json.question do
  json.(@question, :body)
  json.answer_choices do
    json.array!(@question.answer_choices) do |answer_choice|
      json.(answer_choice, :id, :body)
    end
  end
end