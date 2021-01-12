class ChangeDatesInvoices < ActiveRecord::Migration[6.0]
  def change
    change_column :invoices, :physical_date, :date
    change_column :invoices, :system_date,   :date
  end
end
