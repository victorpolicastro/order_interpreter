# frozen_string_literal: true

class InputService
  def initialize(params)
    @params = params
  end

  def call
    buyer = create_buyer
    input_address(buyer)
    order = input_order(buyer)

    OpenStruct.new(success?: true, object: order)
  end

  private

  attr_reader :params

  def create_buyer
    buyer = BuyerCreatorService.new(buyer_params).call.object
    Buyer::PhoneCreatorService.new(buyer: buyer, params: buyer_params[:phone]).call

    buyer
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
    InputOrderService.new(buyer: buyer, params: params).call.object
  end
end
