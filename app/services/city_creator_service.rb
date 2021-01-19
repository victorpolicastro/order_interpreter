# frozen_string_literal: true

class CityCreatorService
  def initialize(state:, params:)
    @state = state
    @name = params[:name]
  end

  def call
    OpenStruct.new(success?: true, object: create_city!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :state, :name

  def create_city!
    city = City.find_or_initialize_by(state: state, name: name)
    city.save!

    city
  end
end
