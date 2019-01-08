FactoryGirl.define do
  factory :user do
    nickname "nickname"
    first_name "frstname"
    second_name "scndname"
    about_users "about user"
    confirmed_at Time.now 
    sequence(:email) { |i| "emailid#{i}@email.com"}
    password "password"
    password_confirmation "password"
  end
end