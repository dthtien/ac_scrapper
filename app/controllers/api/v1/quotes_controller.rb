# frozen-string-literal: true

module Api
  module V1
    class QuotesController < ApplicationController
      def create
        service = Quotes::Create.new(quote_params)
        service.call

        if service.success?
          render json: QuoteSerializer.new(service.quote)
        else
          render json: { success: false, errors: service.errors.to_sentence }, status: 422
        end
      end

      private

      def quote_params
        params.slice(:division, :storey, :address, :email, :name, :phone)
      end
    end
  end
end
