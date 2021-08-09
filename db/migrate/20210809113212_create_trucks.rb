class CreateTrucks < ActiveRecord::Migration[6.1]
  def change
    create_table :trucks do |t|
      t.string :name, null: false
      t.string :owner, null: false
      t.string :city, null: false
      t.decimal :tax_rate, null: false, :precision => 5, :scale => 2
      t.timestamps
    end
  end
end
