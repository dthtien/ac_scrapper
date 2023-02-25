class ItemsController < ApplicationController
  def index
    @items = Item.order(:kwc)
  end
end
