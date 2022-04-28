# == Schema Information
#
# Table name: order_details
#
#  id               :bigint           not null, primary key
#  complete         :boolean
#  completed_at     :datetime
#  final_quantity   :integer
#  quantity         :integer          default(1), not null
#  unit_price_cents :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :bigint           not null
#  product_id       :bigint           not null
#
# Indexes
#
#  index_order_details_on_order_id    (order_id)
#  index_order_details_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  monetize :unit_price_cents, allow_nil: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than: 0, allow_nil: true }

  def remaining_quantity
    quantity - final_quantity
  end
  
end
