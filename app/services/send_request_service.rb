# frozen_string_literal: true

class SendRequestService
  METHOD = 'POST'
  URL = 'https://delivery-center-recruitment-ap.herokuapp.com/'

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
    OpenStruct.new(success?: true, object: send_request)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :order, :order_items, :order_payments, :buyer, :phone, :address, :neighborhood, :city, :state, :country

  def send_request
    response = RestClient::Request.execute(
      method: method.to_sym, url: endpoint, headers: { 'X-sent': x_sent, params: params }
    )
    JSON.parse(response)
  end

  def x_sent
    datetime = Time.current
    "#{datetime.strftime('%Hh%M')} - #{datetime.strftime('%d/%m/%y')}"
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def payload
    {
      externalCode: order.external_code,
      storeId: order.store_id,
      subTotal: order.total_amount,
      deliveryFee: order.total_shipping,
      total_shipping: order.total_shipping,
      total: order.total_amount_with_shipping,
      country: country.code,
      state: state.code,
      city: city.name,
      district: neighborhood.name,
      street: address.street_name,
      complement: address.comment,
      latitude: address.latitude,
      longitude: address.longitude,
      dtOrderCreate: order.date_created,
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

  # rubocop:disable Lint/Void
  def items_payload
    order_items.each do |order_item|
      {
        externalCode: order_item.item.external_code,
        name: order_item.item.name,
        price: order_item.unit_price,
        quantity: order.quantity,
        total: order.full_unit_price,
        subItems: []
      }
    end
  end
  # rubocop:enable Lint/Void

  # rubocop:disable Lint/Void
  def payments_payload
    order_payments.each do |order_payment|
      {
        type: order_payment.payment_type,
        value: order_payment.total_paid_amount
      }
    end
  end
  # rubocop:enable Lint/Void
end
