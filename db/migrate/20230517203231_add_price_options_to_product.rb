class AddPriceOptionsToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price_options, :float, array: true, default: []
  end
end
