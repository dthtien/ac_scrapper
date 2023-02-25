class AddOriginalPriceDetailsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :original_price_details, :text
  end
end
