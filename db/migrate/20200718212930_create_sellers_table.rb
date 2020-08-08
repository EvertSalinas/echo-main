class CreateSellersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :name
      t.timestamps
    end
  end
end
