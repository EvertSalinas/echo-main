class ChangeNullUniPrice < ActiveRecord::Migration[6.0]
  def change
    change_column_null :order_details, :unit_price_cents, true
  end
end
