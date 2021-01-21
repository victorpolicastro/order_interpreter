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

    context 'when creation raises an error' do
      it 'sends errors to logger and retuns success false' do
        allow_any_instance_of(City).to receive(:save!).and_raise(StandardError)
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
