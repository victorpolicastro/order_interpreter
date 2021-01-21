# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendRequestService do
  describe '#call' do
    let!(:buyer) { create(:buyer) }
    let!(:address) { create(:address, buyer: buyer) }
    let!(:phone) { create(:phone, buyer: buyer) }
    let!(:order) { create(:order, buyer: buyer) }
    let!(:order_item) { create(:order_item, order: order) }
    let!(:order_payment) { create(:order_payment, order: order) }

    context 'when request returns 200' do
      it 'returns success' do
        Timecop.freeze do
          stub_request(:post, 'https://delivery-center-recruitment-ap.herokuapp.com/').
            with(
              headers: {
                'Headers'=>{'X-Sent' => Time.zone.now.strftime('%Hh%M - %e/%m/%y')},
                'Host'=>'delivery-center-recruitment-ap.herokuapp.com',
              }).
              to_return(status: 200, body: 'OK', headers: {})

          response = described_class.new(order: order).call

          expect(response).to be_success
        end
      end
    end

    context 'when request returns 500' do
      it 'returns an error message' do
        allow(Rails.logger).to receive(:error).twice

        Timecop.freeze do
          stub_request(:post, 'https://delivery-center-recruitment-ap.herokuapp.com/').
            with(
              headers: {
                'Headers'=>{'X-Sent' => Time.zone.now.strftime('%Hh%M - %e/%m/%y')},
                'Host'=>'delivery-center-recruitment-ap.herokuapp.com',
              }).
              to_return(status: 500, body: 'Internal Server Error', headers: {})

          response = described_class.new(order: order).call

          expect(response).not_to be_success
        end
      end
    end
  end
end
