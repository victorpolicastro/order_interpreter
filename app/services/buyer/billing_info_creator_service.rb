# frozen_string_literal: true

class Buyer
  class BillingInfoCreatorService
    def initialize(buyer:, params:)
      @buyer = buyer
      @doc_type = params[:doc_type]
      @doc_number = params[:doc_number]
    end

    def call
      OpenStruct.new(success?: true, object: create_billing_info!)
    rescue StandardError => e
      Rails.logger.error(e)
      Rails.logger.error(e.backtrace.join("\n"))

      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :buyer, :doc_type, :doc_number

    def create_billing_info!
      BillingInfo.create!(buyer: buyer, doc_type: doc_type, doc_number: doc_number)
    end
  end
end
