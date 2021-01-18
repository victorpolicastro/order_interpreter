# frozen_string_literal: true

class Order
  class PaymentCreatorService
    def initialize(order:, **params)
      @order = order
      @params = params
    end

    def call
      OpenStruct.new(success?: true, object: create_order_payment!)
    rescue StandardError => e
      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :order, :params

    # rubocop:disable Metrics/AbcSize
    def create_order_payment!
      OrderPayment.create!(order: order, external_code: params[:id], payer_id: params[:payer_id],
                           installments: params[:installments], payment_type: params[:payment_type],
                           status: params[:status], transaction_amount: params[:transaction_amount],
                           taxes_amount: params[:taxes_amount], shipping_cost: params[:shipping_cost],
                           total_paid_amount: params[:total_paid_amount], date_created: params[:date_created],
                           installment_amount: params[:installment_amount], date_approved: params[:date_approved])
    end
    # rubocop:enable Metrics/AbcSize
  end
end
