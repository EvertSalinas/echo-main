class RemoveCompleteFromOrderDetails < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_details, :complete
  end
end
