# frozen_string_literal: true

module Api::V1
  class WithdrawalsController < BaseController
    OPERATION = 'You make withdrawal'

    def create
      Services::WithdrawOperation.new(calculation_params).calculate
      render json: { message: OPERATION }, status: :created
    end

    private

    def calculation_params
      params.require(:calculation).permit(:amount, :account_id)
    end
  end
end