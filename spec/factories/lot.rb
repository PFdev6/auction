FactoryBot.define do
  factory :lot do
    association(:user)
    name {"name"}
    start_price {10}
    autopurchase_price {200}
    lot_end_date {Time.new('2000')}
    description {"description"}
  end
end