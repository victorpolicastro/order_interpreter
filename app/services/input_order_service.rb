# frozen_string_literal: true

class InputOrderService
  def initialize(buyer:, params:)
    @buyer = buyer
    @params = params
  end

  def call
    order = create_order
    order_items(order)
    payments(order)
    shipping(order)

    OpenStruct.new(success?: true, object: order)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :buyer, :params

  def create_order
    OrderCreatorService.new(buyer: buyer, params: params).call.object
  end

  def order_items(order)
    InputItemService.new(order: order, params: params[:order_items]).call
  end

  def payments(order)
    params[:payments].each do |payment|
      Order::PaymentCreatorService.new(order: order, params: payment).call
    end
  end

  def shipping(order)
    Order::ShippingCreatorService.new(order: order, params: params[:shipping]).call
  end
end
