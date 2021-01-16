# frozen_string_literal: true

FactoryBot.define do
  factory :neighborhood do
    city
    name { Faker::Address.community }
  end
end
