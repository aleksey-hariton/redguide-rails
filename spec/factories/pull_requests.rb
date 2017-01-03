FactoryGirl.define do
  factory :pull_request do
    url "MyString"
    short "MyString"
    status 1
    message "MyText"
    cookbook_build_id 1
  end
end
