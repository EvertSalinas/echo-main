class AddReferenceToSellerInPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :seller, index: true
  end
end
