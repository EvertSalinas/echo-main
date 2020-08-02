class CreateClientsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :nombre
      t.timestamps
    end
  end
end
