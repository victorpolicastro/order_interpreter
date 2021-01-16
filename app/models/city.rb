# frozen_string_literal: true

class City < ApplicationRecord
  has_many :neighborhoods, dependent: :destroy

  belongs_to :state

  validates :name, presence: true
end
