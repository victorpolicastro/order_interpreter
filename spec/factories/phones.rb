# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    buyer
    area_code { Faker::Number.number(digits: 2) }
    number { Faker::PhoneNumber.phone_number }
  end
end
