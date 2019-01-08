FactoryGirl.define do
  factory :current_bargain do
    association(:user)
    association(:lot)
    current_price 10
    id_user_winner nil
  end
end