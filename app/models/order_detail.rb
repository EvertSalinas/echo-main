# == Schema Information
#
# Table name: order_details
#
#  id               :bigint           not null, primary key
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

  def complete?
    remaining_quantity&.zero?
  end

  def remaining_quantity
    return nil if final_quantity.nil?

    quantity - final_quantity
  end

  def final_price
    return Money.new(0) unless final_quantity.present? && unit_price_cents.present?

    Money.new(final_quantity * unit_price_cents)
  end

end
