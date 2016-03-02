FactoryGirl.define do
  factory :payment do
    email "MyString"
    token "MyString"
    user
  end
end
