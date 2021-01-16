# frozen_string_literal: true

class Order < ApplicationRecord
  has_one :order_shipping, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :order_payments, dependent: :destroy

  belongs_to :buyer

  validates :external_code, :store_id, :date_created, :total_amount, :total_shipping,
            :total_amount_with_shipping, presence: true
end
