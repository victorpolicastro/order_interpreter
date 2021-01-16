class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :external_code
      t.integer :store_id
      t.timestamp :date_created
      t.timestamp :date_closed
      t.timestamp :last_updated
      t.numeric :total_amount
      t.numeric :total_shipping
      t.numeric :total_amount_with_shipping
      t.numeric :paid_amount
      t.datetime :expiration_date
      t.string :status

      t.timestamps
    end
  end
end
