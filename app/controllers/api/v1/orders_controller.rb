# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Api::V1::OrdersController < ApplicationController
  def create
    response = InputService.new(params).call

    return render json: { error: response.message } unless response.success?

    render json: response.object, status: :created
  end
end
# rubocop:enable Style/ClassAndModuleChildren
