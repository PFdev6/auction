FactoryGirl.define do
  factory :lot do
    association(:user)
    name "name"
    start_price 10
    autopurchase_price 200
    lot_end_date Time.now
    description "description"
  end
end