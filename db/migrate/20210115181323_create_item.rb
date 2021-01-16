class CreateItem < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :external_code
      t.string :title

      t.timestamps
    end
  end
end
