# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    user_id 1
    provider "MyString"
    uid "MyString"
    name "MyString"
    screen_name "MyString"
  end
end
