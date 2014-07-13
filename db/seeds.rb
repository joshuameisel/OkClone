# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  {
    username: "josh",
    gender: "m",
    orientation: "straight",
    dob: Date.new(1990, 2, 2),
    country: "us",
    zip_code: 11222,
    email: "joshua@example.com",
    password: "glitch"
  },

  {
    username: "simone",
    gender: "f",
    orientation: "straight",
    min_age: 24,
    max_age: 33,
    dob: Date.new(1988, 12, 28),
    country: "us",
    zip_code: 90210,
    email: "simone@example.com",
    password: "glitch"
  },

  {
    username: "cougar",
    gender: "f",
    orientation: "straight",
    dob: Date.new(1960, 12, 28),
    country: "us",
    zip_code: 90210,
    email: "cougar@example.com",
    password: "glitch"
  },

  {
    username: "jake",
    gender: "m",
    orientation: "straight",
    min_age: 18,
    max_age: 60,
    dob: Date.new(1991, 5, 23),
    country: "us",
    zip_code: 11249,
    email: "jacob@example.com",
    password: "glitch"
  },

  {
    username: "stu2",
    gender: "m",
    orientation: "gay",
    min_age: 20,
    max_age: 26,
    dob: Date.new(1991, 4, 16),
    country: "us",
    zip_code: 10002,
    email: "bryan@example.com",
    password: "glitch"
  },

  {
    username: "frenchfries4ever",
    gender: "m",
    orientation: "gay",
    dob: Date.new(1989, 4, 16),
    country: "us",
    zip_code: 10031,
    email: "rod@example.com",
    password: "glitch"
  },   
])

def straight_male_user(name, zip, birth_yr=1988)
  {
    username: name,
    gender: "m",
    orientation: "straight",
    dob: Date.new(birth_yr, 2, 2),
    country: "us",
    zip_code: zip,
    email: name + "@example.com",
    password: "glitch"
  }
end

users += User.create([
  straight_male_user("frank", 10005, 1977), straight_male_user("benny", 94305),
  straight_male_user("curt", 11211), straight_male_user("stu", 10001)
])

messages = Message.create([
  {
    body: "Hey, how's it going. You seem swell. I noticed you can't swim. " +
      "Do you need an instructor? I know a good one.",
    sender_id: 1,
    recipient_id: 2
  },
  {
    body: "Haha, nah, I can swim, I just say that to impress men.",
    sender_id: 2,
    recipient_id: 1
  },
  {
    body: ("Alright lol. I'm gonna show you how fast I type. " +
      "You'll notice this took me less than a minute to send.") * 7,
    sender_id: 1,
    recipient_id: 2
  },
  {
    body: "yooo",
    sender_id: 3,
    recipient_id: 2
  }
])

profiles = [
  Profile.find_by(user_id: 1).update({
    religion: 0,
    summary: "I'm a real swell guy.",
    likes: "\"Just gimme them French-fried potaters\"",
    most_private: "L-O-L, I-WON'T-TELL"
  }),

  Profile.find_by(user_id: 2).update({
    religion: 0,
    summary: "Just an LA gal tryin' to make it in the big City!",
    likes: "\"The Bachelor,\" the bachelor",
    most_private: "I can't swim, ride a bike, or eat chicken"
  })
]

users[0].photos.create(photo_file: File.open("./db/seed_images/3.jpg"))

(1..2).each do |i|
  users[1].photos.create(photo_file: File.open("./db/seed_images/#{i}.jpg"))
end

questions = Question.create([
  {body: "What's your political affiliation?"}, 
  {body: "Cats or dogs?"}, 
  {body: "What do you admire most?"}, 
  {body: "Are you nosy?"}, 
  {body: "Favorite sport?"}, 
  {body: "I am..."}, 
  {body: "True or false: people spend too much time worrying about " + 
    "superfical things?"}, 
])

questions[0].answer_choices.create([
  {body: "Liberal"}, {body: "Centrist"}, {body: "Conservative"}
])

questions[1].answer_choices.create([
  {body: "Dogs"}, {body: "Cats"}, {body: "Both!"}, {body: "neither :("}
])

questions[2].answer_choices.create([
  {body: "Intelligence"}, {body: "Honesty"}, {body: "Courage"}
])

questions[3].answer_choices.create([{body: "Yes"}, {body: "No"}])

questions[4].answer_choices.create([
  {body: "Basketball"}, {body: "Soccer"}, {body: "Ping pong"}, 
  {body: "Football"}, {body: "Hockey"}
])

questions[5].answer_choices.create([
  {body: "up for anything."}, {body: "a bit reserved."}, 
  {body: "someone who's never left the house."}
])

questions[6].answer_choices.create([
  {body: "True"}, {body: "False"}, {body: "Fralse"}
])

questions.each do |question|
  answer_choices = question.answer_choices
  
  users.each do |user|
    user.answers.create(
      answer_choice: answer_choices[rand(answer_choices.count)]
    )
    
    answer_choices.each do |answer_choice|
      ## coin toss
      if [true, false].sample
        user.acceptable_answers.create(answer_choice_id: answer_choice.id)
      end
    end
  end
end