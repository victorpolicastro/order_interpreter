class CreateOrderPayment < ActiveRecord::Migration[6.1]
  def change
    create_table :order_payments do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :external_code
      t.integer :payer_id
      t.integer :installments
      t.string :payment_type
      t.string :status
      t.numeric :transaction_amount
      t.numeric :taxes_amount
      t.numeric :shipping_cost
      t.numeric :total_paid_amount
      t.numeric :installment_amount
      t.timestamp :date_approved
      t.timestamp :date_created

      t.timestamps
    end
  end
end
