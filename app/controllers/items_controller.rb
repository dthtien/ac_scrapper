class ItemsController < ApplicationController
  def index
    @items = Item.order(:kwc)
    @last_updated_at = @items.map(&:updated_at).max
  end
end
