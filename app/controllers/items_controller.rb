class ItemsController < ApplicationController
  def index
    @data = AirConditionersScraper.new.call
  end
end
