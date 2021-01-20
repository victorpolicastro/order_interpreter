class CreateOrderItem < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.numeric :unit_price
      t.numeric :full_unit_price

      t.timestamps
    end
  end
end
