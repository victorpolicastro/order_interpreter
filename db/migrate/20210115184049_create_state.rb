class CreateState < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.references :country, null: false, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
