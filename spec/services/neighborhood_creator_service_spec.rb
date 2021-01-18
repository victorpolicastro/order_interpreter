# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NeighborhoodCreatorService do
  describe '#call' do
    let!(:city) { create(:city) }
    let!(:neighborhood) { build(:neighborhood) }
    let(:service) do
      described_class.new(city: city, id: neighborhood.external_code, name: neighborhood.name)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Neighborhood) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(Neighborhood).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
