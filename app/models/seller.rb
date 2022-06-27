# == Schema Information
#
# Table name: sellers
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Seller < ApplicationRecord

  has_many :invoices, dependent: :nullify
  has_many :payments

  validates :name, uniqueness: true

  def sold_amount
    Money.new(invoices.sum(:total_amount_cents))
  end

  def clients
    invoices.joins(:client).pluck(:name).uniq
  end

end
