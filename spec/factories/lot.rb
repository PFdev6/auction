FactoryGirl.define do
  factory :lot do
    association(:user)
    name "name"
    description "description"
  end
end