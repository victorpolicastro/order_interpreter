# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order::ItemCreatorService do
  describe '#call' do
    let!(:order) { create(:order) }
    let!(:item) { create(:item) }
    let!(:order_item) { create(:order_item) }
    let(:params) do
      {
        quantity: order_item.quantity, unit_price: order_item.unit_price, full_unit_price: order_item.full_unit_price
      }
    end
    let(:service) do
      described_class.new(order: order, item: item, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(OrderItem) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(OrderItem).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
