# frozen_string_literal: true

class Order
  class Shipping < ApplicationRecord
    belongs_to :order
  end
end
