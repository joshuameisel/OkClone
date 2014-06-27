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
    email: "joshua.a.meisel@gmail.com",
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
    email: "simone",
    password: "glitch"
  },
  
  {
    username: "cougar",
    gender: "f",
    orientation: "straight",
    dob: Date.new(1960, 12, 28),
    country: "us",
    zip_code: 90210,
    email: "cougar@gmail.com",
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
    email: "jacob",
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
    email: "bryan@gmail.com",
    password: "glitch"
  }, 
  
  {
    username: "rod",
    gender: "m",
    orientation: "gay",
    dob: Date.new(1989, 4, 16),
    country: "us",
    zip_code: 10031,
    email: "rod@gmail.com",
    password: "glitch"
  }
])

Profile.find(2).update({
  religion: "Jew",
  summary: "Just an LA gal tryin' to make it in the big City!",
  likes: "\"The Bachelor,\" the bachelor",
  most_private: "When I swim my fingies get pruny"
})