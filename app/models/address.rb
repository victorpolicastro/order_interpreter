# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :buyer
  belongs_to :neighborhood

  validates :street_name, :latitude, :longitude, :zip_code, :street_number, presence: true
end
