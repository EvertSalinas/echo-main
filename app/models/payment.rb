# == Schema Information
#
# Table name: payments
#
#  id             :bigint           not null, primary key
#  amount_cents   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  invoice_id     :bigint
#  payment_log_id :bigint
#  seller_id      :bigint
#
# Indexes
#
#  index_payments_on_invoice_id      (invoice_id)
#  index_payments_on_payment_log_id  (payment_log_id)
#  index_payments_on_seller_id       (seller_id)
#
class Payment < ApplicationRecord
  acts_as_paranoid

  belongs_to :payment_log, touch: true
  belongs_to :invoice,     touch: true
  belongs_to :seller

  monetize :amount_cents

  validate :payment_log_remaining_balance
  validate :invoice_remaining_debt

  after_update :check_relationships_status
  after_destroy :check_relationships_status

  private

  def payment_log_remaining_balance
    if amount > payment_log.remaining_balance
      errors[:base] << I18n.t("errors.payment.remaining_balance")
    end
  end

  def invoice_remaining_debt
    if amount > invoice.remaining_debt
      errors[:base] << "Payment should be at most the invoice remaining debt"
    end
  end

  def check_relationships_status
    invoice.paid_out? ? invoice.pagada! : invoice.pendiente!
    payment_log.depleted? ? payment_log.agotado! : payment_log.abierto!
  end

end
