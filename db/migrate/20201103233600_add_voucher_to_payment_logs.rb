class AddVoucherToPaymentLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_logs, :voucher, :string, unique: true
  end
end
