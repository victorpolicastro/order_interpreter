# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    state
    name { Faker::Address.city }
  end
end
