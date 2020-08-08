# == Schema Information
#
# Table name: invoices
#
#  id                     :bigint           not null, primary key
#  cantidad_total         :decimal(, )      not null
#  condicion              :string           not null
#  estatus                :integer          default("pendiente"), not null
#  fecha_factura          :datetime         not null
#  fecha_remision         :datetime         not null
#  folio_remision_factura :string           not null
#  folio_remision_fisica  :string           not null
#  lugar                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  client_id              :bigint
#  seller_id              :bigint
#
# Indexes
#
#  index_invoices_on_client_id  (client_id)
#  index_invoices_on_estatus    (estatus)
#  index_invoices_on_seller_id  (seller_id)
#
class Invoice < ApplicationRecord

  CONDITIONS = %w(credito contado).freeze

  belongs_to :client
  belongs_to :seller
  has_many   :payments

  enum estatus: { pendiente: 0, pagada: 1, cancelada: 2 }

  validates :cantidad_total,         presence: true
  validates :condicion,              presence: true, inclusion: { in: CONDITIONS }
  validates :fecha_factura,          presence: true
  # validates :fecha_remision, presence: true # TODO
  validates :folio_remision_factura, presence: true, uniqueness: true
  validates :folio_remision_fisica,  presence: true, uniqueness: true
  validates :lugar,                  presence: true

  scope :with_remaining_debt, -> { joins(:payments).where("cantidad_total > SUM(payments.amount)") }

  # TODO when payment is created change status
  
  def remaining_debt
    cantidad_total - payments.sum(:amount)
  end

  def paid_out?
    remaining_debt.zero?
  end

end
