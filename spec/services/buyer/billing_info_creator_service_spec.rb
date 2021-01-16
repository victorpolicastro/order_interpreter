# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buyer::BillingInfoCreatorService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:billing_info) { build(:billing_info) }

    context 'when valid' do
      let!(:response) do
        described_class.new(buyer: buyer, doc_type: billing_info.doc_type, doc_number: billing_info.doc_number).call
      end

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(BillingInfo) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(BillingInfo).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = described_class.new(buyer: buyer, doc_type: billing_info.doc_type,
                                       doc_number: billing_info.doc_number).call

        expect(response).not_to be_success
      end
    end
  end
end
