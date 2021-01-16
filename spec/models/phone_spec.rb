# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone do
  describe 'association' do
    it { is_expected.to belong_to(:buyer) }
  end

  describe 'validations' do
    %i[area_code number].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
