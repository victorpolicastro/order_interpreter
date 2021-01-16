# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  describe 'associations' do
    it { is_expected.to belong_to(:buyer) }
    it { is_expected.to belong_to(:neighborhood) }
  end

  describe 'validations' do
    %i[street_name latitude longitude zip_code street_number].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
