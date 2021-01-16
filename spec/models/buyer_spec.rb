# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buyer do
  describe 'associations' do
    it { is_expected.to have_one(:billing_info).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_many(:phones).dependent(:destroy) }
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
  end

  describe 'validations' do
    %i[external_code nickname email].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
