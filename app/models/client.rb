# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord

  # include SalesKpis

  has_many :invoices,     dependent: :nullify
  has_many :payment_logs, dependent: :nullify

  validates :name, uniqueness: true

  def pending_invoices
    invoices.pendiente
  end

  def remaining_debt
    Money.new(pending_invoices.sum(&:remaining_debt))
  end

  def sellers
    invoices.joins(:seller).pluck(:name).uniq
  end

end
