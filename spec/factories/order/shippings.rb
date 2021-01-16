# frozen_string_literal: true

FactoryBot.define do
  factory :order_shipping, class: 'Order::Shipping' do
    order
  end
end
