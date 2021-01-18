# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :external_code, :title, presence: true
end
