# frozen_string_literal: true

module Api::V1
  class DepositsController < BaseController
    OPERATION = 'You make deposit'

    def create
      Services::DepositOperation.new(calculation_params).calculate
      render json: { message: OPERATION }, status: :created
    end

    private

    def calculation_params
      params.require(:calculation).permit(:amount, :account_id)
    end
  end
end
