# frozen_string_literal: true

class Order
  class ItemCreatorService
    def initialize(order:, item:, **params)
      @order = order
      @item = item
      @quantity = params[:quantity]
      @unit_price = params[:unit_price]
      @full_unit_price = params[:full_unit_price]
    end

    def call
      OpenStruct.new(success?: true, object: create_order_item!)
    rescue StandardError => e
      Rails.logger.error(e)
      Rails.logger.error(e.backtrace.join("\n"))

      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :order, :item, :quantity, :unit_price, :full_unit_price

    def create_order_item!
      OrderItem.create!(order: order, item: item, quantity: quantity, unit_price: unit_price,
                        full_unit_price: full_unit_price)
    end
  end
end
