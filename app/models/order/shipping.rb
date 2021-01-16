# frozen_string_literal: true

module Order
  class Shipping < ApplicationRecord
    belongs_to :order
  end
end
