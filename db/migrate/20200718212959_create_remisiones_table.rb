class CreateRemisionesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :remissions do |t|
      t.string   :condicion,              null: false
      t.string   :folio_remision_fisica,  null: false
      t.string   :folio_remision_factura, null: false
      t.datetime :fecha_factura,          null: false
      t.integer  :cantidad_total_cents,   null: false
      t.datetime :fecha_remision,         null: false
      t.string   :lugar,                  null: false
      t.string   :status,                 null: false, default: 'pendiente'

      t.references :client
      t.references :seller

      t.timestamps
    end
  end
end
