# frozen_string_literal: true

class InputAddressService
  def initialize(buyer:, params:)
    @buyer = buyer
    @params = params
  end

  def call
    OpenStruct.new(success?: true, object: address)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :buyer, :params

  def address
    AddressCreatorService.new(buyer: buyer, neighborhood: neighborhood, params: params).call.object
  end

  def neighborhood
    NeighborhoodCreatorService.new(city: city, params: params[:neighborhood]).call.object
  end

  def city
    CityCreatorService.new(state: state, params: params[:city]).call.object
  end

  def state
    StateCreatorService.new(country: country, params: params[:state]).call.object
  end

  def country
    CountryCreatorService.new(params: params[:country]).call.object
  end
end
