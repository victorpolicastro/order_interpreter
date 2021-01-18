# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StateCreatorService do
  describe '#call' do
    let!(:country) { create(:country) }
    let!(:state) { build(:state) }
    let(:service) do
      described_class.new(country: country, name: state.name, code: state.code)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(State) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(State).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
