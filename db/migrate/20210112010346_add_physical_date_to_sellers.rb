class AddPhysicalDateToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_logs, :physical_date, :date
  end
end
