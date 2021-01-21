# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State do
  describe 'associations' do
    it { is_expected.to have_many(:cities) }
    it { is_expected.to belong_to(:country) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
