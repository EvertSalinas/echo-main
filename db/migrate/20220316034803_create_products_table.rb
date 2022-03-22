class CreateProductsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku, null: false
      t.string :name, null: false
      t.string :line
      t.string :aux_sku
      t.string :in_stock

      t.timestamps
    end

    add_index :products, :sku, unique: true
  end
end
