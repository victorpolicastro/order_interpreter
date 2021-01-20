# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputOrderService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:order) { build(:order) }
    let(:payload) do
      {
        id: order.external_code,
        store_id: order.store_id,
        date_created: order.date_created,
        date_closed: order.date_closed,
        last_updated: order.last_updated,
        total_amount: order.total_amount,
        total_amount_with_shipping: order.total_amount_with_shipping,
        paid_amount: order.paid_amount,
        expiration_date: order.expiration_date,
        total_shipping: order.total_shipping,
        order_items: [
          {
            item: {
              id: Faker::Lorem.characters(number: 10),
              title: Faker::Lorem.word
            },
            quantity: Faker::Number.number(digits: 1),
            unit_price: Faker::Number.decimal(l_digits: 2),
            full_unit_price: Faker::Number.decimal(l_digits: 2)
          }
        ],
        payments: [
          {
            id: Faker::Lorem.characters(number: 10),
            order_id: nil,
            payer_id: nil,
            installments: nil,
            payment_type: 'credit_card',
            status: nil,
            transaction_amount: nil,
            taxes_amount: nil,
            shipping_cost: nil,
            total_paid_amount: Faker::Number.decimal(l_digits: 2),
            installment_amount: nil,
            date_approved: nil,
            date_created: nil
          }
        ],
        shipping: {
          id: nil,
          shipment_type: nil,
          date_created: nil,
        },
        status: order.status
      }
    end
    let(:service) do
      described_class.new(buyer: buyer, params: payload)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Order) }
      it { expect(Order.count).to eq(1) }
      it { expect(Item.count).to eq(1) }
      it { expect(OrderItem.count).to eq(1) }
      it { expect(OrderPayment.count).to eq(1) }
      it { expect(OrderShipping.count).to eq(1) }
    end
  end
end
