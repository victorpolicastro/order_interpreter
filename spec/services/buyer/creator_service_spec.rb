# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buyer::CreatorService do
  describe '#call' do
    context 'when valid' do
      let!(:buyer_params) { build(:buyer).as_json.deep_symbolize_keys }
      let!(:response) { described_class.new(buyer_params).call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Buyer) }
    end

    context 'when invalid' do
      let!(:buyer_params) { build(:buyer).as_json.deep_symbolize_keys }

      it 'sends errors to logger and retuns success false' do
        allow(Buyer).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = described_class.new(buyer_params).call

        expect(response).not_to be_success
      end
    end
  end
end
