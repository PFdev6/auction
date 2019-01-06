# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'admin@admin.com', 
  password: 'password',
  password_confirmation: 'password', 
  nickname: 'Admin', first_name:'Admin', 
  second_name:'Admin', 
  confirmed_at: Time.now,
  avatar: '',
  isadmin: true
  ) if Rails.env.development?

30.times do
  User.create(
    nickname: Faker::App.name,
    email: Faker::Internet.email,
    about_users: Faker::Beer.name,
    first_name: Faker::Name.first_name,
    second_name: Faker::Name.last_name, 
    confirmed_at: Time.now,
    password: 'qwe123',
    password_confirmation: 'qwe123'
  )
end


