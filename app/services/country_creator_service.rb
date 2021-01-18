# frozen_string_literal: true

class CountryCreatorService
  def initialize(**params)
    @code = params[:id]
    @name = params[:name]
  end

  def call
    OpenStruct.new(success?: true, object: create_country!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :code, :name

  def create_country!
    Country.create!(code: code, name: name)
  end
end
