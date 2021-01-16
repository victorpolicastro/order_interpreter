# frozen_string_literal: true

class Phone < ApplicationRecord
  belongs_to :buyer

  validates :area_code, :number, presence: true
end
