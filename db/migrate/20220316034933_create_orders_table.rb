class CreateOrdersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :folio
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
