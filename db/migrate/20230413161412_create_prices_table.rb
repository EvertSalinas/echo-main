class CreatePricesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.integer :amount_cents, null: false

      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
