class AddAdminUserIdToInvoces < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoices, :admin_user, index: true
  end
end
