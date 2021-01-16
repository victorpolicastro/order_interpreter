# frozen_string_literal: true

FactoryBot.define do
  factory :order_item, class: 'Order::Item' do
    order
    item
    quantity { Faker::Number.number(digits: 1) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    full_unit_price { quantity * unit_price }
  end
end
