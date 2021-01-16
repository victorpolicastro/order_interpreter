# frozen_string_literal: true

class Neighborhood < ApplicationRecord
  has_many :addresses, dependent: :destroy

  belongs_to :city

  validates :name, presence: true
end
