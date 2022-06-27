class AddClientToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :client, null: false, foreign_key: true
  end
end
