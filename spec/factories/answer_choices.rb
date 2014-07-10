# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_choice do |n|
    sequence(:body) { |n| "blahblahblah#{n}"}
  end
end