class AddUnitPriceToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :unit_price_cents, :integer
    add_column :order_details, :complete, :boolean
    add_column :order_details, :completed_at, :datetime
    add_column :order_details, :final_quantity, :integer
  end
end
