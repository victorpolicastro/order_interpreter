# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem do
  describe 'associations' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    %i[quantity unit_price full_unit_price].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
