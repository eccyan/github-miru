# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blob do
    authentication_id 1
    branch "MyString"
    head_sha "MyString"
    repository_name "MyString"
    path "MyString"
  end
end
