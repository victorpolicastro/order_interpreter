# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    buyer
    area_code { Faker::PhoneNumber.area_code }
    number { Faker::PhoneNumber.phone_number }
  end
end
