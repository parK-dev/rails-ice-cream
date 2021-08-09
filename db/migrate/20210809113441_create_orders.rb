class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :sales_tax, null: false, :precision => 5, :scale => 2
      t.decimal :cost_before_tax, null: false, :precision => 5, :scale => 2
      t.decimal :cost_after_tax, null: false, :precision => 5, :scale => 2
      t.references :truck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
