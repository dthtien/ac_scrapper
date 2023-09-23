module Api
  module V1
    module Items
      class RefreshesController < ApplicationController
        skip_before_action :verify_authenticity_token

        def update
          Scrapers::AirConditionersScraper.new.call
          render json: { success: true }
        end
      end
    end
  end
end

