# frozen_string_literal: true

FactoryBot.define do
  factory :buyer do
    external_code { Faker::Number.number(digits: 10) }
    nickname { Faker::Movies::LordOfTheRings.character }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    doc_type { 'CPF' }
    doc_number { Faker::IDNumber.brazilian_citizen_number }
  end
end
