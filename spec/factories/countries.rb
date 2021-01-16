# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    code { Faker::Address.country_code }
    name { Faker::Address.country }
  end
end
