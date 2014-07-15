json.user {json.partial!("user", user: @user, questions: @questions)} if @user

if @current_user
  json.current_user do
    json.partial!("user", user: @current_user, questions: @questions)
  end
end

json.questions do
  json.array!(@questions) do |question|
    json.(question, :body)
    json.answer_choices do
      json.array!(question.answer_choices) do |answer_choice|
        json.(answer_choice, :id, :body)
      end
    end
  end
end