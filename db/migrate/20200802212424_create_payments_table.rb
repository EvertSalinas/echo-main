class CreatePaymentsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false

      t.references :payment_log
      t.references :invoice

      t.timestamps
    end
  end
end
