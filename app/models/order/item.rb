# frozen_string_literal: true

module Order
  class Item < ApplicationRecord
    belongs_to :order
    belongs_to :item

    validates :quantity, :unit_price, :full_unit_price, presence: true
  end
end
