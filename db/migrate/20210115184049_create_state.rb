class CreateState < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
