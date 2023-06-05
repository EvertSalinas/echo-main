class AddOtherPriceToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :order_details, :other_price_cents, :integer, default: 0
  end
end
