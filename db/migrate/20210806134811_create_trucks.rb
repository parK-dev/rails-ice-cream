class CreateTrucks < ActiveRecord::Migration[6.1]
  def change
    create_table :trucks do |t|
      t.string :name
      t.string :owner
      t.string :city

      t.timestamps
    end
  end
end
