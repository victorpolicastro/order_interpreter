# frozen_string_literal: true

class CityCreatorService
  def initialize(state:, name:)
    @state = state
    @name = name
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
    City.create!(state: state, name: name)
  end
end
