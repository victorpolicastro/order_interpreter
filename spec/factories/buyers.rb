# frozen_string_literal: true

FactoryBot.define do
  factory :buyer do
    external_code { Faker::Lorem.characters(number: 10) }
    nickname { Faker::Movies::LordOfTheRings.character }
    email { Faker::Internet.email }
  end
end
