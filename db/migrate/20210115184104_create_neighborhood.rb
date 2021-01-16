class CreateNeighborhood < ActiveRecord::Migration[6.1]
  def change
    create_table :neighborhoods do |t|
      t.references :city, null: false, foreign_key: true
      t.bigint :external_code
      t.string :name

      t.timestamps
    end
  end
end
