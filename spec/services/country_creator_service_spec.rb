# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryCreatorService do
  describe '#call' do
    let!(:country) { build(:country) }
    let(:params) do
      {
        id: country.code, name: country.name
      }
    end
    let(:service) do
      described_class.new(params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Country) }
    end

    context 'when creation raises an error' do
      it 'sends errors to logger and retuns success false' do
        allow_any_instance_of(Country).to receive(:save!).and_raise(StandardError)
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
