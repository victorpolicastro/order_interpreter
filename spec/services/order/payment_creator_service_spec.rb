# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order::PaymentCreatorService do
  describe '#call' do
    let!(:order) { create(:order) }
    let!(:payment) { create(:order_payment) }
    let(:params) do
      {
        id: payment.external_code, payer_id: payment.payer_id, installments: payment.installments,
        payment_type: payment.payment_type, status: payment.status, transaction_amount: payment.transaction_amount,
        taxes_amount: payment.taxes_amount, shipping_cost: payment.shipping_cost,
        total_paid_amount: payment.total_paid_amount, date_created: payment.date_created,
        installment_amount: payment.installment_amount, date_approved: payment.date_approved
      }
    end
    let(:service) do
      described_class.new(order: order, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(OrderPayment) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(OrderPayment).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
