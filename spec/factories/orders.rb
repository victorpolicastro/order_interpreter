# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    buyer
    external_code { Faker::Lorem.characters(number: 10) }
    store_id { Faker::Number.number(digits: 3) }
    date_created { Time.current }
    total_amount { Faker::Number.decimal(l_digits: 2) }
    total_shipping { Faker::Number.decimal(l_digits: 2) }
    total_amount_with_shipping { total_amount + total_shipping }
  end
end
