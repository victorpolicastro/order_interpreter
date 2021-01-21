class CreateBuyer < ActiveRecord::Migration[6.1]
  def change
    create_table :buyers do |t|
      t.bigint :external_code
      t.string :nickname
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :doc_type
      t.string :doc_number

      t.timestamps
    end
  end
end
