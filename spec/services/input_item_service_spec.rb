# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputItemService do
  describe '#call' do
    let!(:order) { create(:order) }
    let!(:item) { build(:item) }
    let!(:payload) do
      [{
        item: {
          id: item.external_code,
          title: item.title
        },
        quantity: Faker::Number.number(digits: 1),
        unit_price: Faker::Number.decimal(l_digits: 2),
        full_unit_price: Faker::Number.decimal(l_digits: 2)
      }]
    end
    let(:service) do
      described_class.new(order: order, params: payload)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(Item.count).to eq(1) }
      it { expect(OrderItem.count).to eq(1) }
    end
  end
end
