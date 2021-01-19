# frozen_string_literal: true

class StateCreatorService
  def initialize(country:, params:)
    @country = country
    @name = params[:name]
    @code = params[:code]
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
    state = State.find_or_initialize_by(country: country, name: name, code: code)
    state.save!

    state
  end
end
