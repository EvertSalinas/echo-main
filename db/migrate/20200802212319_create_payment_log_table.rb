class CreatePaymentLogTable < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_logs do |t|
      t.decimal :total_amount, null: false

      t.references :client

      t.timestamps
    end
  end
end
