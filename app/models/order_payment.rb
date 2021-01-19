# frozen_string_literal: true

class OrderPayment < ApplicationRecord
  belongs_to :order

  enum payment_type: { credit_card: 'credit_card', debit_card: 'debit_card', billet: 'billet' }

  validates :payment_type, :total_paid_amount, presence: true
end
