# frozen_string_literal: true

class NeighborhoodCreatorService
  def initialize(city:, params:)
    @city = city
    @external_code = params[:external_code]
    @name = params[:name]
  end

  def call
    OpenStruct.new(success?: true, object: create_neighborhood!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :city, :external_code, :name

  def create_neighborhood!
    neighborhood = Neighborhood.find_or_initialize_by(city: city, external_code: external_code, name: name)
    neighborhood.save!

    neighborhood
  end
end
