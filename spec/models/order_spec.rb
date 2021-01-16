# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    %i[external_code store_id date_created total_amount total_shipping
       total_amount_with_shipping].each do |field|
      it { is_expected.to(validate_presence_of(field)) }
    end
  end
end
