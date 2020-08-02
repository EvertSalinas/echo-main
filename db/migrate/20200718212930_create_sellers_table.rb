class CreateSellersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :nombre
      t.timestamps
    end
  end
end
