module Items
  class RefreshesController < ApplicationController
    def update
      Scrapers::AirConditionersScraper.new.call

      redirect_to :root
    end
  end
end
