# frozen_string_literal: true

class InputItemService
  def initialize(order:, params:)
    @order = order
    @order_items = params
  end

  def call
    order_items.each do |order_item|
      item = _item(order_item[:item])
      _order_item(order, item, order_item)
    end

    OpenStruct.new(success?: true)
  end

  private

  attr_reader :order, :order_items

  def _item(params)
    response = ItemCreatorService.new(params).call
    response.object
  end

  def _order_item(order, item, params)
    Order::ItemCreatorService.new(order: order, item: item, params: params).call
  end
end
