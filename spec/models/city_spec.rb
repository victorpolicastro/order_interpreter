# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City do
  describe 'association' do
    it { is_expected.to have_many(:neighborhoods).dependent(:destroy) }
    it { is_expected.to belong_to(:state) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
