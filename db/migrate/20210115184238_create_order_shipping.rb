class CreateOrderShipping < ActiveRecord::Migration[6.1]
  def change
    create_table :order_shippings do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :external_code
      t.string :shipment_type
      t.datetime :date_created

      t.timestamps
    end
  end
end
