FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name {  Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { "2016-02-29 12:29:57" }
  end
end
