# frozen_string_literal: true

class BuyerCreatorService
  def initialize(params)
    @external_code = params[:id]
    @nickname = params[:nickname]
    @email = params[:email]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @doc_type = params[:billing_info][:doc_type]
    @doc_number = params[:billing_info][:doc_number]
  end

  def call
    OpenStruct.new(success?: true, object: create_buyer!)
  rescue StandardError => e
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, messages: e.message)
  end

  private

  attr_reader :external_code, :nickname, :email, :first_name, :last_name, :doc_type, :doc_number

  def create_buyer!
    Buyer.create!(external_code: external_code, nickname: nickname, email: email, first_name: first_name,
                  last_name: last_name, doc_type: doc_type, doc_number: doc_number)
  end
end
