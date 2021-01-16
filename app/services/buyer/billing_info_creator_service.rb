# frozen_string_literal: true

class Buyer
  class BillingInfoCreatorService
    def initialize(buyer:, doc_type:, doc_number:)
      @buyer = buyer
      @doc_type = doc_type
      @doc_number = doc_number
    end

    def call
      OpenStruct.new(success?: true, object: create_billing_info!)
    rescue StandardError => e
      Rails.logger.error(e.backtrace.join("\n"))
      Rails.logger.error(e)

      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :buyer, :doc_type, :doc_number

    def create_billing_info!
      BillingInfo.create!(buyer: buyer, doc_type: doc_type, doc_number: doc_number)
    end
  end
end
