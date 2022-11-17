FactoryBot.define do
  factory :purchase_destination do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number { Faker::Number.between(from: 1_000_000_000, to: 99_999_999_999) }
    association :item
  end
end
