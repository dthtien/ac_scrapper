class AddImageUrlToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :image_url, :text
  end
end
