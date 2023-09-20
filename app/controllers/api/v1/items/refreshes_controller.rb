module Api
  module V1
    module Items
      class RefreshesController < ApplicationController
        def update
          Scrapers::AirConditionersScraper.new.call
          render json: { success: true }
        end
      end
    end
  end
end

