# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  aux_sku       :string
#  in_stock      :string
#  line          :string
#  name          :string           not null
#  price_options :integer          default([]), is an Array
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

  def self.sku_sales
    sql = <<~SQL.strip
      SELECT p.name, sum(od.final_quantity) as cantidad
      FROM order_details od
      INNER JOIN products p ON p.id = od.product_id
      GROUP BY p.name
      ORDER BY count(*) DESC
      LIMIT 10
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end

  def displayable_prices
    price_options.map do |price|
      "$#{price/100.0}"
    end.join("\n")
  end

  def serialize_array
    prices = price_options_text.remove('$').split

    prices.all? do |price|
      raise ArgumentError unless Float(price) != nil
    rescue ArgumentError
      errors.add(:price_options, 'Precio incorrecto')
    end

    self.price_options = prices.map do |price|
      (price.to_f.round(2) * 100)
    end
  end
end
