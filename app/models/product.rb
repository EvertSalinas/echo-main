# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  aux_sku    :string
#  in_stock   :string
#  line       :string
#  name       :string           not null
#  sku        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_products_on_sku  (sku) UNIQUE
#
class Product < ApplicationRecord

  has_many :order_details
  has_many :orders, through: :order_details

  validates :sku, presence: true, uniqueness: true
  validates :name, presence: true

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
end
      # ORDER BY count(*) DESC
