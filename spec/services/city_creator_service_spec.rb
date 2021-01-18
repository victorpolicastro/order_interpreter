# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CityCreatorService do
  describe '#call' do
    let!(:state) { create(:state) }
    let!(:city) { build(:city) }
    let(:service) do
      described_class.new(state: state, name: city.name)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(City) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(City).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
