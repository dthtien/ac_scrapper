module Items
  class RefreshesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def update
      Scrapers::AirConditionersScraper.new.call

      redirect_to :root
    end
  end
end
