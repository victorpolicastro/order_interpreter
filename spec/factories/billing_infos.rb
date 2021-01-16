# frozen_string_literal: true

FactoryBot.define do
  factory :billing_info do
    buyer
    doc_type { 'CPF' }
    doc_number { Faker::IDNumber.brazilian_citizen_number }
  end
end
