class AddQuantityToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :quantity, :integer, null: false, default: 1
  end
end
