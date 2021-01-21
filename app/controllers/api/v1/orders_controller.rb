# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Api::V1::OrdersController < ApplicationController
  def create
    order = InputService.new(params).call.object
    response = SendRequestService.new(order: order).call

    return render json: { error: response.message }, status: :unprocessable_entity unless response.success?

    render json: response.object, status: :created
  end
end
# rubocop:enable Style/ClassAndModuleChildren
