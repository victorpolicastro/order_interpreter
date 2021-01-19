# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StateCreatorService do
  describe '#call' do
    let!(:country) { create(:country) }
    let!(:state) { build(:state) }
    let(:params) do
      {
        name: state.name, code: state.code
      }
    end
    let(:service) do
      described_class.new(country: country, params: params)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(State) }
    end
  end
end
