# frozen_string_literal: true

class ItemCreatorService
  def initialize(params)
    @external_code = params[:id]
    @title = params[:title]
  end

  def call
    OpenStruct.new(success?: true, object: create_item!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_reader :external_code, :title

  def create_item!
    Item.create!(external_code: external_code, title: title)
  end
end
