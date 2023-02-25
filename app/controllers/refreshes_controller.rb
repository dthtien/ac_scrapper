class RefreshesController < ApplicationController
  def update
    AirConditionersScraper.new.call

    redirect_to :root
  end
end
