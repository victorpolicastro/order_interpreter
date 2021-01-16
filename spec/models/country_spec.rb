# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country do
  describe 'association' do
    it { is_expected.to have_many(:states).dependent(:destroy) }
  end

  describe 'validations' do
    %i[code name].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
