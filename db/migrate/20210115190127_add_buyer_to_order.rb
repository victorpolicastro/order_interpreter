class AddBuyerToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :buyer, null: false, foreign_key: true
  end
end
