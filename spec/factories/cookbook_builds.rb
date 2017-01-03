FactoryGirl.define do
  factory :cookbook_build do
    cookbook_id 1
    foodcritic_status 1
    cookstyle_status 1
    rspec_status 1
    kitchen_status 1
    approve_status 1
    commit_sha "MyString"
    remote_branch "MyString"
    build_job_id 1
  end
end
