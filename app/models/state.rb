# frozen_string_literal: true

class State < ApplicationRecord
  has_many :cities, dependent: :destroy

  belongs_to :country

  validates :code, :name, presence: true
end
