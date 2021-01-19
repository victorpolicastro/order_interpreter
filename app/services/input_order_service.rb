# frozen_string_literal: true

class InputOrderService
  def initialize(buyer:, params:)
    @buyer = buyer
    @params = params
  end

  def call
    order_items
    payments
    shipping

    OpenStruct.new(success?: true, object: order)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :buyer, :params

  def order
    @order ||= Order::CreatorService.new(buyer: buyer, params: params).call.object
  end

  def order_items
    InputItemService.new(order: order, params: params[:order_items]).call
  end

  def payments
    params[:payments].each do |payment|
      Order::PaymentCreatorService.new(order: order, params: payment).call
    end
  end

  def shipping
    Order::ShippingCreatorService.new(order: order, params: params[:shipping]).call
  end
end
