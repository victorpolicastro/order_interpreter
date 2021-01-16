# frozen_string_literal: true

class Order
  class Item < ApplicationRecord
    belongs_to :item
    belongs_to :order

    validates :quantity, :unit_price, :full_unit_price, presence: true
  end
end
