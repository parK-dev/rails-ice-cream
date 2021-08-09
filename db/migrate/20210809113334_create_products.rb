class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, null: false, :precision => 5, :scale => 2
      t.integer :stock, null: false
      t.string :type, null: false
      t.string :flavour
      t.references :truck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
