class CreatePaymentLogTable < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_logs do |t|
      t.integer :total_amount_cents, null: false
      t.string  :folio,              null: false

      t.references :client

      t.timestamps
    end
  end
end
