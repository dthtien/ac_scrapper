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

      def show
        item = Item.find_by(id: params[:id])
        if item.present?
          render json: ItemSerializer.new(item)
        else
          render json: { error: 'Item not found' }, status: :not_found
        end
      end
    end
  end
end
