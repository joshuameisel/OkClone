json.user {json.partial!("user", user: @user, answer: @user_answer)} if @user

if current_user
  json.current_user do
    json.partial!("user", user: current_user, answer: @current_user_answer)
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