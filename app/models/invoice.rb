# == Schema Information
#
# Table name: invoices
#
#  id                 :bigint           not null, primary key
#  condition          :string           not null
#  physical_date      :datetime         not null
#  physical_folio     :string           not null
#  place              :string           not null
#  status             :integer          default("pendiente"), not null
#  system_date        :datetime         not null
#  system_folio       :string           not null
#  total_amount_cents :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :bigint
#  seller_id          :bigint
#
# Indexes
#
#  index_invoices_on_client_id     (client_id)
#  index_invoices_on_seller_id     (seller_id)
#  index_invoices_on_status        (status)
#  index_invoices_on_system_folio  (system_folio)
#
class Invoice < ApplicationRecord

  CONDITIONS = %w(credito contado).freeze

  belongs_to :client
  belongs_to :seller
  has_many   :payments

  enum status: { pendiente: 0, pagada: 1, cancelada: 2 }

  monetize :total_amount_cents

  validates :condition,              presence: true, inclusion: { in: CONDITIONS }
  validates :physical_date,          presence: true
  validates :system_date,            presence: true
  validates :system_folio,           presence: true, uniqueness: true
  validates :physical_folio,         presence: true, uniqueness: true
  validates :place,                  presence: true

  after_commit :pay, unless: :pagada?

  def remaining_debt
    total_amount - Money.new(payments.sum(:amount_cents))
  end

  def paid_out?
    remaining_debt.zero?
  end

  def days_passed
    return 0 if pagada?

    (Date.current - physical_date.to_date).to_i
  end

  private

  def pay
    pagada! if paid_out?
  end

end
