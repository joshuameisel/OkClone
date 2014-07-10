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
    username: "bryan",
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
    username: "conservative_dude",
    gender: "m",
    orientation: "straight",
    dob: Date.new(1987, 2, 2),
    country: "us",
    zip_code: 10004,
    email: "conservative@example.com",
    password: "glitch"
  },

  {
    username: "rod",
    gender: "m",
    orientation: "gay",
    dob: Date.new(1989, 4, 16),
    country: "us",
    zip_code: 10031,
    email: "rod@example.com",
    password: "glitch"
  }
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