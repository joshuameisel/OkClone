json.user {json.partial!("user", user: @user, answer: @answers[@user])} if @user

if current_user
  json.current_user do
    json.partial!("user", user: current_user, answer: @answers[current_user])
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