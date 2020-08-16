class CreateInvoicesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string   :condition,              null: false
      t.string   :physical_folio,         null: false
      t.string   :system_folio,           null: false, index: true
      t.datetime :physical_date,          null: false
      t.datetime :system_date,            null: false
      t.decimal  :total_amount_cents,     null: false
      t.string   :place,                  null: false
      t.integer  :status,                 null: false, default: 0, index: true

      t.references :client
      t.references :seller

      t.timestamps
    end
  end
end
