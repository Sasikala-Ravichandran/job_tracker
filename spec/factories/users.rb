FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name {  Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { "2016-02-29 12:29:57" }
  
    transient do
      count 5
    end

    factory :user_with_documents do
      after(:create) do |user, evaluator|
        (0...evaluator.count).each do |i|
          user.documents << FactoryGirl.create(:document, name: "Document_#{i}")
        end
      end
    end

    factory :user_with_positions do
      after(:create) do |user, evaluator|
        (0...evaluator.count).each do |i|
          user.positions << FactoryGirl.create(:position)
        end
      end
    end
  end
end
