FactoryGirl.define do
  factory :error_report do
    stacktrace "MyText"
    error_msg "MyText"
    error_passed "MyText"
    changed_resources "MyText"
    node nil
  end
end
