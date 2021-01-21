# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Api::V1::OrdersController < ApplicationController
  def create
    order_response = InputService.new(params).call

    return render json: { error: order_response.message }, status: :unprocessable_entity unless order_response.success?

    response = SendRequestService.new(order: order_response.object).call

    return render json: { error: response.message }, status: :unprocessable_entity unless response.success?

    render json: response.object, status: :created
  end
end
# rubocop:enable Style/ClassAndModuleChildren
