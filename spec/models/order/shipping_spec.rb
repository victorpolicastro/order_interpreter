# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order::Shipping do
  describe 'association' do
    it { is_expected.to belong_to(:order) }
  end
end
