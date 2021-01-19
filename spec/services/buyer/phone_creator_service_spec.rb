# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buyer::PhoneCreatorService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:phone) { build(:phone) }
    let(:params) do
      {
        area_code: phone.area_code, number: phone.number
      }
    end
    let(:service) do
      described_class.new(buyer: buyer, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Phone) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(Phone).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
