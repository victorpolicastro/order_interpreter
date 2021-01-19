# frozen_string_literal: true

class InputBuyerService
  def initialize(params)
    @params = params
  end

  def call
    billing_info
    phone

    OpenStruct.new(success?: true, object: buyer)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :params

  def buyer
    @buyer ||= Buyer::CreatorService.new(params).call.object
  end

  def billing_info
    Buyer::BillingInfoCreatorService.new(buyer: buyer, params: params[:billing_info]).call
  end

  def phone
    Buyer::PhoneCreatorService.new(buyer: buyer, params: params[:phone]).call
  end
end
