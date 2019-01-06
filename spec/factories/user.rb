FactoryGirl.define do
  factory :user do
    nickname "nickname"
    first_name "frstname"
    second_name "scndname"
    about_user "about user"
    sequence(:email) { |i| "emailid#{i}@email.com"}
    password "password"
  end
end