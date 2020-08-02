class CreateInvoicesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string   :condicion,              null: false
      t.string   :folio_remision_fisica,  null: false
      t.string   :folio_remision_factura, null: false
      t.datetime :fecha_factura,          null: false
      t.decimal  :cantidad_total,         null: false
      t.datetime :fecha_remision,         null: false
      t.string   :lugar,                  null: false
      t.integer  :estatus,                null: false, default: 0, index: true

      t.references :client
      t.references :seller

      t.timestamps
    end
  end
end
