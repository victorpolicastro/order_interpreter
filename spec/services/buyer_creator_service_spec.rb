# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuyerCreatorService do
  describe '#call' do
    let!(:buyer) { build(:buyer) }
    let(:payload) do
      {
        id: buyer.external_code,
        nickname: buyer.nickname,
        email: buyer.email,
        first_name: buyer.first_name,
        last_name: buyer.last_name,
        billing_info: {
          doc_type: buyer.doc_type,
          doc_number: buyer.doc_number
        }
      }
    end
    let(:service) do
      described_class.new(payload)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Buyer) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(Buyer).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
