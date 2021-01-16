class CreatePhone < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.references :buyer, null: false, foreign_key: true
      t.integer :area_code
      t.string :number

      t.timestamps
    end
  end
end
