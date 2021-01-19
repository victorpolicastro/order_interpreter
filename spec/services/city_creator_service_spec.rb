# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CityCreatorService do
  describe '#call' do
    let!(:state) { create(:state) }
    let!(:city) { build(:city) }
    let(:params) do
      {
        name: city.name
      }
    end
    let(:service) do
      described_class.new(state: state, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(City) }
    end
  end
end
