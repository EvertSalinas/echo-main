class AddAdminUserToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :admin_user, null: false, foreign_key: true
  end
end
