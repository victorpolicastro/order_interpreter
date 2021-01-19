# frozen_string_literal: true

class Order
  class ShippingCreatorService
    def initialize(order:, **params)
      @order = order
      @external_code = params[:id]
      @date_created = params[:date_created]
    end

    def call
      OpenStruct.new(success?: true, object: create_order_shipping!)
    rescue StandardError => e
      Rails.logger.error(e)
      Rails.logger.error(e.backtrace.join("\n"))

      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :order, :external_code, :date_created

    def create_order_shipping!
      OrderShipping.create!(order: order, external_code: external_code, date_created: date_created)
    end
  end
end
