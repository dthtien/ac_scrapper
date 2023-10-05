# frozen-string-literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        @items = Item.search(params[:query]).order(:kwc)
        render json: ItemSerializer.new(
          @items,
          meta: { last_updated_at: @items.map(&:updated_at).max }
        )
      end
    end
  end
end
