# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository do
    authentication_id 1
    name "MyString"
    branch "MyString"
    head_sha "MyString"
  end
end
