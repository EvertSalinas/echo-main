class AddSequentialIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :sequential_id, :integer
  end
end
