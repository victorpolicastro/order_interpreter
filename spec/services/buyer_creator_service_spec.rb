# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuyerCreatorService do
  describe '#call' do
    let!(:buyer) { build(:buyer) }
    let(:service) do
      described_class.new(id: buyer.external_code, nickname: buyer.nickname, email: buyer.email,
                          first_name: buyer.first_name, last_name: buyer.last_name)
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
