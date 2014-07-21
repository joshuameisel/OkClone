json.current_user do
  json.partial!(
    "user",
    user: current_user,
    answer: @answer,
    acceptable_answers: @acceptable_answers
  )
end