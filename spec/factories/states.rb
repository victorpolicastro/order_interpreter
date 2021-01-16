# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    country
    code { Faker::Address.state_abbr }
    name { Faker::Address.state }
  end
end
