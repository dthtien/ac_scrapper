class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :division
      t.string :storey
      t.integer :user_id, index: true
      t.text :address

      t.timestamps
    end
  end
end
