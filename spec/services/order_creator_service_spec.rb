# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderCreatorService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:order) { build(:order) }
    let(:params) do
      {
        id: order.external_code, store_id: order.store_id, date_created: order.date_created,
        date_closed: order.date_closed, last_updated: order.last_updated, total_amount: order.total_amount,
        total_shipping: order.total_shipping, paid_amount: order.paid_amount, expiration_date: order.expiration_date,
        status: order.status, total_amount_with_shipping: order.total_amount_with_shipping
      }
    end
    let(:service) do
      described_class.new(buyer: buyer, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Order) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(Order).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
