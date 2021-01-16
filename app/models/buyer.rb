# frozen_string_literal: true

class Buyer < ApplicationRecord
  has_one :billing_info, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :phones, dependent: :destroy

  validates :external_code, :nickname, :email, presence: true
end
