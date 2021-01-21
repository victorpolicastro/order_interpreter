# frozen_string_literal: true

class SendRequestService
  METHOD = 'POST'
  ENDPOINT = 'https://delivery-center-recruitment-ap.herokuapp.com/'

  def initialize(order:)
    @order = order
    @order_items = order.order_items
    @order_payments = order.order_payments
    @buyer = order.buyer
    @phone = @buyer.phones.last
    @address = @buyer.addresses.last
    @neighborhood = @address.neighborhood
    @city = @neighborhood.city
    @state = @city.state
    @country = @state.country
  end

  def call
    OpenStruct.new(success?: true, message: send_request)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :order, :order_items, :order_payments, :buyer, :phone, :address, :neighborhood, :city, :state, :country

  def send_request
    RestClient.post(ENDPOINT, payload.to_json, headers: { 'X-Sent' => x_sent }).body
  end

  def x_sent
    Time.zone.now.strftime('%Hh%M - %e/%m/%y')
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def payload
    {
      externalCode: order.external_code,
      storeId: order.store_id,
      subTotal: order.total_amount.to_f,
      deliveryFee: order.total_shipping.to_f,
      total_shipping: order.total_shipping.to_f,
      total: order.total_amount_with_shipping.to_f,
      country: country.code,
      state: state.code,
      city: city.name,
      district: neighborhood.name,
      street: address.street_name,
      complement: address.comment,
      latitude: address.latitude,
      longitude: address.longitude,
      dtOrderCreate: order.date_created.to_s,
      postalCode: address.zip_code,
      number: address.street_number,
      customer: {
        externalCode: buyer.external_code,
        name: buyer.nickname,
        email: buyer.email,
        contact: "#{phone.area_code}#{phone.number}"
      },
      items: items_payload,
      payments: payments_payload
    }
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def items_payload
    order_items.map do |order_item|
      {
        externalCode: order_item.item.external_code,
        name: order_item.item.title,
        price: order_item.unit_price.to_f,
        quantity: order_item.quantity,
        total: order_item.full_unit_price.to_f,
        subItems: []
      }
    end
  end

  def payments_payload
    order_payments.map do |order_payment|
      {
        type: order_payment.payment_type,
        value: order_payment.total_paid_amount.to_f
      }
    end
  end
end
