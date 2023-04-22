class ItemsController < ApplicationController
  def index
    @items = Item.search(params[:query]).order(:kwc)
    @last_updated_at = @items.map(&:updated_at).max
  end
end
