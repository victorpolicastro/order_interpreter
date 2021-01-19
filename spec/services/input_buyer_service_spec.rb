# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputBuyerService do
  describe '#call' do
    let(:buyer) { build(:buyer) }
    let(:phone) { build(:phone) }
    let(:billing_info) { build(:billing_info) }
    let!(:payload) do
      {
        id: buyer.external_code,
        nickname: buyer.nickname,
        email: buyer.email,
        phone: {
          area_code: Faker::Number.number(digits: 2),
          number: Faker::PhoneNumber.phone_number
        },
        first_name: buyer.first_name,
        last_name: buyer.last_name,
        billing_info: {
          doc_type: 'CPF',
          doc_number: Faker::IDNumber.brazilian_citizen_number
        }
      }
    end
    let(:service) do
      described_class.new(payload)
    end

    context 'when valid' do
      let!(:response) { service.call }

      it { expect(response).to be_success }
      it { expect(response.object).to be_a(Buyer) }
      it { expect(Buyer.count).to eq(1) }
      it { expect(Phone.count).to eq(1) }
      it { expect(BillingInfo.count).to eq(1) }
    end
  end
end
