# frozen_string_literal: true

class AddressCreatorService
  def initialize(buyer:, neighborhood:, **params)
    @buyer = buyer
    @neighborhood = neighborhood
    @params = params
  end

  def call
    OpenStruct.new(success?: true, object: create_address!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :buyer, :neighborhood, :params

  # rubocop:disable Metrics/AbcSize
  def create_address!
    Address.create!(buyer: buyer, neighborhood: neighborhood, external_code: params[:id],
                    address_line: params[:address_line], street_name: params[:street_name],
                    street_number: params[:street_number], comment: params[:comment], zip_code: params[:zip_code],
                    latitude: params[:latitude], longitude: params[:longitude], receiver_phone: params[:receiver_phone])
  end
  # rubocop:enable Metrics/AbcSize
end
