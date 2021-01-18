# frozen_string_literal: true

class Order
  class CreatorService
    def initialize(buyer:, **params)
      @buyer = buyer
      @params = params
    end

    def call
      OpenStruct.new(success?: true, object: create_order!)
    rescue StandardError => e
      Rails.logger.error(e)
      Rails.logger.error(e.backtrace.join("\n"))

      OpenStruct.new(success?: false, message: e.message)
    end

    private

    attr_reader :buyer, :params

    # rubocop:disable Metrics/AbcSize
    def create_order!
      Order.create!(buyer: buyer, external_code: params[:id], store_id: params[:store_id],
                    date_created: params[:date_created], date_closed: params[:date_closed],
                    last_updated: params[:last_updated], total_amount: params[:total_amount],
                    total_shipping: params[:total_shipping], paid_amount: params[:paid_amount],
                    expiration_date: params[:expiration_date], status: params[:status],
                    total_amount_with_shipping: params[:total_amount_with_shipping])
    end
    # rubocop:enable Metrics/AbcSize
  end
end
