# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemCreatorService do
  describe '#call' do
    let!(:item) { build(:item) }
    let(:service) { described_class.new(id: item.external_code, title: item.title) }

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Item) }
    end

    context 'when invalid' do
      it 'sends errors to logger and retuns success false' do
        allow(Item).to receive(:create!).and_raise(StandardError).once
        allow(Rails.logger).to receive(:error).twice

        response = service.call

        expect(response).not_to be_success
      end
    end
  end
end
