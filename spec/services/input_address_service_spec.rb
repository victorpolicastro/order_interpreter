# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputAddressService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:address) { build(:address) }
    let(:neighborhood) { address.neighborhood }
    let(:city) { neighborhood.city }
    let(:state) { city.state }
    let(:country) { state.country }
    let!(:payload) do
      {
        id: 1_051_695_306,
        address_line: address.address_line,
        street_name: address.street_name,
        street_number: address.street_number,
        comment: address.comment,
        zip_code: address.zip_code,
        city: {
          name: city.name
        },
        state: {
          code: state.code,
          name: state.name
        },
        country: {
          id: country.code,
          name: country.name
        },
        neighborhood: {
          id: neighborhood.external_code,
          name: neighborhood.name
        },
        latitude: address.latitude,
        longitude: address.longitude,
        receiver_phone: address.receiver_phone
      }
    end
    let(:service) do
      described_class.new(buyer: buyer, params: payload)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Address) }
      it { expect(Address.count).to eq(1) }
      it { expect(Neighborhood.count).to eq(1) }
      it { expect(City.count).to eq(1) }
      it { expect(State.count).to eq(1) }
      it { expect(Country.count).to eq(1) }
    end
  end
end
