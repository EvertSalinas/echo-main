# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  aux_sku       :string
#  in_stock      :string
#  line          :string
#  name          :string           not null
#  price_options :float            default([]), is an Array
#  sku           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_products_on_sku  (sku) UNIQUE
#
class Product < ApplicationRecord
  attr_accessor :price_options_text

  has_many :order_details
  has_many :orders, through: :order_details

  validates :sku, presence: true, uniqueness: true
  validates :name, presence: true

  before_validation :serialize_array

  def serialize_array
    return unless price_options_text

    prices = price_options_text.remove('$').split

    prices.all? do |price|
      raise ArgumentError unless Float(price) != nil
    rescue ArgumentError
      errors.add(:price_options, 'Precio incorrecto')
    end

    self.price_options = prices.map(&:to_f)
  end
end
