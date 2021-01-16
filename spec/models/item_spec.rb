# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  describe 'association' do
    it { is_expected.to have_many(:order_items).class_name('Order::Item') }
  end

  describe 'validations' do
    %i[external_code title].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
