# frozen_string_literal: true

module Order
  class Payment < ApplicationRecord
    belongs_to :order

    validates :payment_type, :total_paid_amount, presence: true
  end
end
