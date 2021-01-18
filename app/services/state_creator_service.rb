# frozen_string_literal: true

class StateCreatorService
  def initialize(country:, name:, code:)
    @country = country
    @name = name
    @code = code
  end

  def call
    OpenStruct.new(success?: true, object: create_state!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :country, :name, :code

  def create_state!
    State.create!(country: country, name: name, code: code)
  end
end
