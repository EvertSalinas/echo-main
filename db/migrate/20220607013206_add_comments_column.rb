class AddCommentsColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :comments, :text
  end
end
