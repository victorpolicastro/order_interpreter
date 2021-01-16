# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order::Payment do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    %i[payment_type total_paid_amount].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe 'enum' do
    let!(:order_payment) { create(:order_payment) }

    it { expect(order_payment).to be_credit_card }

    context 'when payment_type is debit_card' do
      before do
        order_payment.debit_card!
      end

      it { expect(order_payment).to be_debit_card }
    end

    context 'when payment_type is billet' do
      before do
        order_payment.billet!
      end

      it { expect(order_payment).to be_billet }
    end
  end
end
