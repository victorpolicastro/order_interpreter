# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order::ShippingCreatorService do
  describe '#call' do
    let!(:order) { create(:order) }
    let!(:shipping) { build(:order_shipping) }
    let(:service) do
      described_class.new(order: order, id: shipping.external_code, date_created: shipping.date_created)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(OrderShipping) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(OrderShipping).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
