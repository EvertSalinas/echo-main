class AddInvoiceIdtoPaymentLog < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_logs, :invoice_id, :integer
  end
end
