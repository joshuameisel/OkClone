FactoryGirl.define do
  factory :user do
    username {Faker::Name.name}
    orientation "straight"
    country "us"
    email {Faker::Internet.email}
    password "glitch"
    zip_code 90210
  end
end