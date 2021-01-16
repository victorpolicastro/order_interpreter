class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.integer :external_code
      t.string :address_line
      t.string :street_name
      t.string :street_number
      t.string :comment
      t.string :zip_code
      t.numeric :latitude
      t.numeric :longitude
      t.string :receiver_phone

      t.timestamps
    end
  end
end
