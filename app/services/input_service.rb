# frozen_string_literal: true

class InputService
  def initialize(params)
    @params = params
  end

  def call
    buyer = create_buyer
    input_address(buyer)
    input_order(buyer)

    OpenStruct.new(success?: true)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :params

  def create_buyer
    InputBuyerService.new(buyer_params).call.object
  end

  def buyer_params
    params[:buyer]
  end

  def input_address(buyer)
    InputAddressService.new(buyer: buyer, params: address_params).call
  end

  def address_params
    params[:shipping][:receiver_address]
  end

  def input_order(buyer)
    InputOrderService.new(buyer: buyer, params: params).call
  end
end
