# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    external_code { Faker::Lorem.characters(number: 10) }
    title { Faker::Lorem.word }
  end
end
