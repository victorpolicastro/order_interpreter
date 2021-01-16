# frozen_string_literal: true

class Buyer
  class PhoneCreatorService
    def initialize(buyer:, area_code:, number:)
      @buyer = buyer
      @area_code = area_code
      @number = number
    end

    def call
      OpenStruct.new(success?: true, object: create_phone!)
    rescue StandardError => e
      Rails.logger.error(e.backtrace.join("\n"))
      Rails.logger.error(e)

      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :buyer, :area_code, :number

    def create_phone!
      Phone.create!(buyer: buyer, area_code: area_code, number: number)
    end
  end
end
