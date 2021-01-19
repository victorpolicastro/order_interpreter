# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NeighborhoodCreatorService do
  describe '#call' do
    let!(:city) { create(:city) }
    let!(:neighborhood) { build(:neighborhood) }
    let(:params) do
      {
        id: neighborhood.external_code, name: neighborhood.name
      }
    end
    let(:service) do
      described_class.new(city: city, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Neighborhood) }
    end
  end
end
