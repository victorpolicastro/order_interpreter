# frozen_string_literal: true

class Order < ApplicationRecord
  has_one :order_shipping, class_name: 'Order::Shipping', dependent: :destroy
  has_many :order_items, class_name: 'Order::Item', dependent: :destroy
  has_many :order_payments, class_name: 'Order::Payment', dependent: :destroy

  belongs_to :buyer

  validates :external_code, :store_id, :date_created, :total_amount, :total_shipping,
            :total_amount_with_shipping, presence: true
end
