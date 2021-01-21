# frozen_string_literal: true

class InputBuyerService
  def initialize(params)
    @params = params
  end

  def call
    buyer = create_buyer
    phone(buyer)

    OpenStruct.new(success?: true, object: buyer)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :params

  def create_buyer
    BuyerCreatorService.new(params).call.object
  end

  def phone(buyer)
    ::Buyer::PhoneCreatorService.new(buyer: buyer, params: params[:phone]).call
  end
end
