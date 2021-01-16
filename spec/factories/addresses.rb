# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    buyer
    neighborhood
    street_name { Faker::Address.street_name }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    zip_code { Faker::Address.zip_code }
    street_number { Faker::Number.number(digits: 3) }
  end
end
