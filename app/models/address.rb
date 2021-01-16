# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :buyer
  belongs_to :neighborhood

  validates :street_name, :latitude, :longitude, :zip_code, :number, presence: true
end
