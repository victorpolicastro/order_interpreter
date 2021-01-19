# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :quantity, :unit_price, :full_unit_price, presence: true
end
