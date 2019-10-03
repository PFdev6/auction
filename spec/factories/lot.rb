FactoryBot.define do
  factory :lot do
    name { 'name' }
    start_price { 10 }
    autopurchase_price { 200 }
    lot_end_date { Time.new('2000') }
    description { 'description' }

    after(:create) do |obj|
      obj.current_bargain_id = obj.current_bargain.id
      obj.save
    end

    association :user
  end
end
