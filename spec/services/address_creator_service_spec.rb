# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressCreatorService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:neighborhood) { create(:neighborhood) }
    let!(:address) { build(:address) }
    let(:params) do
      {
        id: address.external_code, address_line: address.address_line, street_name: address.street_name,
        street_number: address.street_number, comment: address.comment, zip_code: address.zip_code,
        latitude: address.latitude, longitude: address.longitude, receiver_phone: address.receiver_phone
      }
    end
    let(:service) do
      described_class.new(buyer: buyer, neighborhood: neighborhood, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Address) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(Address).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
