class AddBlockedToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :blocked, :boolean, default: false
  end
end
