# frozen_string_literal: true

class City < ApplicationRecord
  has_many :neighborhoods, dependent: :destroy

  belongs_to :country

  validates :name, presence: true
end
