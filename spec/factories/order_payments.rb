# frozen_string_literal: true

FactoryBot.define do
  factory :order_payment do
    order
    payment_type { 'credit_card' }
    total_paid_amount { Faker::Number.decimal(l_digits: 2) }
  end
end
