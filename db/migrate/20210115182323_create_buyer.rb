class CreateBuyer < ActiveRecord::Migration[6.1]
  def change
    create_table :buyers do |t|
      t.integer :external_code
      t.string :nickname
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
