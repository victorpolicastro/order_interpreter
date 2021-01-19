# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:order_shipping).dependent(:destroy) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many(:order_payments).dependent(:destroy) }
    it { is_expected.to belong_to(:buyer) }
  end

  describe 'validations' do
    %i[external_code store_id date_created total_amount total_shipping
       total_amount_with_shipping].each do |field|
      it { is_expected.to(validate_presence_of(field)) }
    end
  end
end
