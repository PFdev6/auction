FactoryBot.define do
  factory :user do
    nickname { 'nickname' }
    first_name { 'frstname' }
    second_name { 'scndname' }
    about_users { 'about user' }
    password { 'qwe123' }
    password_confirmation { 'qwe123' }
    confirmed_at { Time.now }
    email { Faker::Internet.email }


    trait :admin do
      email { 'admin@admin.com' }                
      password { 'password' }  
      password_confirmation { 'password' }   
      nickname { 'Admin' }   
      first_name { 'Admin' }
      second_name { 'Admin' }   
      about_users { 'about user' }
      confirmed_at { Time.now }  
      isadmin { true }  
    end
  end
end