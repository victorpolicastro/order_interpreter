# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillingInfo do
  describe 'association' do
    it { is_expected.to belong_to(:buyer) }
  end
end
