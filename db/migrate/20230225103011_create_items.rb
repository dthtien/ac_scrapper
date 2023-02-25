class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.text :title
      t.string :kwc
      t.string :price

      t.timestamps
    end
  end
end
